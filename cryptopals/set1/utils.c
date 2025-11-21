#include "./utils.h"
#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

static const char *base64_alphabet =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

Buffer buffer_new(size_t size) {
  return (Buffer){.size = size, .content = calloc(size, sizeof(uint8_t))};
}

Buffer buffer_from_string(const char *phrase) {
  Buffer result = buffer_new(strlen(phrase));
  for (size_t i = 0; i < strlen(phrase); ++i)
    result.content[i] = phrase[i];
  return result;
}

bool equal_buffer(const Buffer a, const Buffer b) {
  if (a.size != b.size)
    return false;
  for (size_t i = 0; i < a.size; ++i)
    if (a.content[i] != b.content[i])
      return false;
  return true;
}

Buffer decode_hex(const char *hex) {
  Buffer result = (Buffer){
      .content = calloc(strlen(hex) / 2, sizeof(uint8_t)),
      .size = strlen(hex) / 2,
  };
  size_t ridx = 0;
  char buf[2];
  for (size_t i = 0; i < strlen(hex); i += 2) {
    buf[0] = hex[i];
    buf[1] = hex[i + 1];
    uint out = 0;
    sscanf(buf, "%x", &out);
    /* printf("%2d - %s - %3d\n", i, buf, out); */
    result.content[ridx++] = out;
  }
  return result;
}

char *encode_hex(Buffer buffer) {
  char *result = calloc((buffer.size * 2) + 1, sizeof(char));
  size_t ridx = 0;
  for (size_t i = 0; i < buffer.size; ++i) {
    char buf[3];
    sprintf(buf, "%02x", buffer.content[i]);
    strncpy(&result[ridx], buf, sizeof(char) * 2);
    ridx += 2;
  }
  return result;
}

char *encode_ascii(const Buffer buffer) {
  char *result = calloc(buffer.size + 1, sizeof(char));
  for (size_t i = 0; i < buffer.size; ++i)
    result[i] = buffer.content[i];
  return result;
}

Buffer xor_buffers(Buffer a, Buffer b) {
  assert(a.size == b.size);
  Buffer result = (Buffer){
      .content = calloc(a.size, sizeof(uint8_t)),
      .size = a.size,
  };
  for (size_t i = 0; i < a.size; ++i) {
    result.content[i] = a.content[i] ^ b.content[i];
  }
  return result;
}

Buffer xor_buffer(const Buffer src_buffer, uint8_t by) {
  Buffer result = buffer_new(src_buffer.size);
  for (size_t i = 0; i < src_buffer.size; ++i) {
    result.content[i] = src_buffer.content[i] ^ by;
  }
  return result;
}

int decode_base64_char(const char letter) {
  if (letter == '=') {
    return 0;
  }
  for (size_t i = 0; i < strlen(base64_alphabet); ++i)
    if (letter == base64_alphabet[i])
      return i;
  return -1;
}

char *encode_base64(Buffer buffer) {
  char *result = calloc((buffer.size * 8 / 6) + 3, sizeof(char));
  char step = 0;
  uint8_t previous_char = 0;
  size_t result_idx = 0;
  for (size_t i = 0; i < buffer.size; ++i) {
    uint8_t current_char = buffer.content[i];
    bool is_last_byte = i == (buffer.size - 1);
    switch (step) {
    case 0: {
      uint8_t bidx = (current_char & 0xFC) >> 2; // 0b11111100
      result[result_idx++] = base64_alphabet[bidx];
      if (is_last_byte) {
        bidx = (current_char & 0x03) << 4; // 0b00000011
        result[result_idx++] = base64_alphabet[bidx];
        result[result_idx++] = '=';
        result[result_idx++] = '=';
      }
      step++;
      break;
    }
    case 1: {
      uint8_t bidx = (current_char & 0xF0) >> 4; // 0b11110000
      bidx |= (previous_char & 0x03) << 4;       // 0b00000011
      result[result_idx++] = base64_alphabet[bidx];
      if (is_last_byte) {
        bidx = (current_char & 0x0F) << 2; // 0b00001111
        result[result_idx++] = base64_alphabet[bidx];
        result[result_idx++] = '=';
      }
      step++;
      break;
    }
    case 2: {
      uint8_t bidx = (current_char & 0xC0) >> 6; // 0b11000000
      bidx |= (previous_char & 0x0F) << 2;       // 0b00001111
      result[result_idx++] = base64_alphabet[bidx];
      bidx = current_char & 0x3F; // 0b00111111
      result[result_idx++] = base64_alphabet[bidx];
      step = 0;
      break;
    }
    default:
      assert(false);
    }
    previous_char = current_char;
  }
  return result;
}

static const int english_scores[] = {
    ['U'] = 2,  ['u'] = 2,  ['L'] = 3,  ['l'] = 3,  ['D'] = 4,  ['d'] = 4,
    ['R'] = 5,  ['r'] = 5,  ['H'] = 6,  ['h'] = 6,  ['S'] = 7,  ['s'] = 7,
    [' '] = 8,  ['N'] = 9,  ['n'] = 9,  ['I'] = 10, ['i'] = 10, ['O'] = 11,
    ['o'] = 11, ['A'] = 12, ['a'] = 12, ['T'] = 13, ['t'] = 13, ['E'] = 14,
    ['e'] = 14, [255] = 0,
};

static int letter_score(const char letter) {
  if (letter == ' ')
    return 8;
  if (!isalpha(letter))
    return -1;
  return english_scores[letter];
}

static int english_score(const Buffer phrase) {
  int score = 0;
  for (size_t i = 0; i < phrase.size; ++i) {
    score += letter_score(phrase.content[i]);
  }
  return score;
}

BruteforceResult bruteforce_xor(Buffer phrase) {
  BruteforceResult result = (BruteforceResult){
      .buffer = buffer_new(phrase.size),
  };
  for (uint8_t i = 0; i < 127; ++i) {
    Buffer tmp = xor_buffer(phrase, i);
    int tmp_score = english_score(tmp);
    /* printf("%3d %3d - %s\n", tmp_score, result.score, encode_ascii(tmp)); */
    if (tmp_score > result.score) {
      result.score = tmp_score;
      for (size_t j = 0; j < phrase.size; ++j) {
        result.buffer.content[j] = tmp.content[j];
      };
    }
    free(tmp.content);
  }
  return result;
}
