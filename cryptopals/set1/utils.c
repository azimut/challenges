#include "./utils.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

const char base64_alphabet[64] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

Buffer new_buffer(size_t size) {
  return (Buffer){.size = size, .content = calloc(size, sizeof(uint8_t))};
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

char *encode_base64(Buffer buffer) {
  char *result = calloc((buffer.size * 8 / 6) + 3, sizeof(char));
  char step = 0;
  uint8_t prev_hex = 0;
  size_t result_idx = 0;
  for (size_t i = 0; i < buffer.size; ++i) {
    uint8_t current_hex = buffer.content[i];
    switch (step) {
    case 0: {
      uint8_t bidx = (current_hex & 0xFC) >> 2; // 0b11111100
      result[result_idx++] = base64_alphabet[bidx];
      step++;
      break;
    }
    case 1: {
      uint8_t bidx = (current_hex & 0xF0) >> 4; // 0b11110000
      bidx |= (prev_hex & 0x03) << 4;           // 0b00000011
      result[result_idx++] = base64_alphabet[bidx];
      step++;
      break;
    }
    case 2: {
      uint8_t bidx = (current_hex & 0xC0) >> 6; // 0b11000000
      bidx |= (prev_hex & 0x0F) << 2;           // 0b00001111
      result[result_idx++] = base64_alphabet[bidx];
      bidx = current_hex & 0x3F; // 0b00111111
      result[result_idx++] = base64_alphabet[bidx];
      step = 0;
      break;
    }
    }
    prev_hex = current_hex;
  }
  return result;
}
