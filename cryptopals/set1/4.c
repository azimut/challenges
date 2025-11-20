#include "./utils.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

const char english_common[26] = "ETAOINSRHLDCUMFPGWYBVKXJQZ";

// Returns a 26 elements array, with each letter frequency in PHRASE.
int8_t *letter_frequencies(const Buffer phrase) {
  int8_t *result = calloc(26, sizeof(int8_t));
  for (size_t i = 0; i < phrase.size; ++i)
    if (isalpha(phrase.content[i]))
      result[toupper(phrase.content[i]) - 'A']++;
  return result;
}

// Returns the index of the max value in ARR, or -1
int max_index(int8_t *arr) {
  int result = -1;
  for (size_t i = 0; i < 26; ++i) {
    if (result == -1)
      result = i;
    if (arr[i] > arr[result]) {
      result = i;
    }
  }
  return result;
}

char *sort_by_frequencies(const Buffer phrase) {
  char *result = calloc(28, sizeof(char));
  int8_t *frequencies = letter_frequencies(phrase);
  for (size_t i = 0; i < 26; ++i) {
    int tidx = max_index(frequencies);
    if (tidx < 0) {
      break;
    }
    result[i] = (char)(tidx + 'A');
    frequencies[tidx] = -1;
  }
  free(frequencies);
  return result;
}

bool is_top6(const char letter) {
  char c = toupper(letter);
  return (c == 'E' || c == 'T' || c == 'A' || c == 'O' || c == 'I' || c == 'N');
}

bool is_bottom6(const char letter) {
  char c = toupper(letter);
  return (c == 'V' || c == 'K' || c == 'J' || c == 'X' || c == 'Q' || c == 'Z');
}

bool is_printable(const Buffer phrase) {
  for (size_t i = 0; i < phrase.size; ++i)
    if (!(phrase.content[i] >= 32 && phrase.content[i] <= 126))
      return false;
  return true;
}

short english_score(const Buffer phrase) {
  short score = 0;
  if (!is_printable(phrase))
    return score;
  char *phrase_common = sort_by_frequencies(phrase);
  for (size_t i = 0; i < 6; ++i)
    if (is_top6(phrase_common[i]))
      score++;
  for (size_t i = 25; i >= 20; i--)
    if (is_bottom6(phrase_common[i]))
      score++;
  free(phrase_common);
  return score;
}

typedef struct BruteforceResult {
  uint score;
  Buffer buffer;
} BruteforceResult;

BruteforceResult bruteforce_xor(Buffer phrase) {
  BruteforceResult result = (BruteforceResult){
      .buffer = new_buffer(phrase.size),
  };
  puts("----");
  for (uint8_t i = 0; i < 127; ++i) {
    Buffer tmp = xor_buffer(phrase, i);
    uint tmp_score = english_score(tmp);
    if (is_printable(tmp)) {
      printf("%2d - %s - %s\n", tmp_score, sort_by_frequencies(tmp),
             encode_ascii(tmp));
    }
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

int main(void) {
  FILE *f = fopen("4.txt", "r");
  char buf[256];
  while (fgets(buf, 255, f)) {
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    /* if (english_score(encode_ascii(decode_hex(buf))) > 0) { */
    /*   printf("%s - %2d - %s - %s\n", buf, */
    /*          english_score(encode_ascii(decode_hex(buf))), */
    /*          sort_by_frequencies(encode_ascii(decode_hex(buf))), */
    /*          encode_ascii(decode_hex(buf))); */
    /* } */
    BruteforceResult br = bruteforce_xor(decode_hex(buf));
    if (br.score > 0) {
      printf("%s - %2d - %s - %s\n", buf, br.score,
             sort_by_frequencies(br.buffer), encode_ascii(br.buffer));
    }
  }
  fclose(f);
  return 0;
}
