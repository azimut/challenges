#include "./utils.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static const int english_scores[] = {
    ['U'] = 2,  ['u'] = 2,  ['L'] = 3,  ['l'] = 3,  ['D'] = 4,  ['d'] = 4,
    ['R'] = 5,  ['r'] = 5,  ['H'] = 6,  ['h'] = 6,  ['S'] = 7,  ['s'] = 7,
    [' '] = 8,  ['N'] = 9,  ['n'] = 9,  ['I'] = 10, ['i'] = 10, ['O'] = 11,
    ['o'] = 11, ['A'] = 12, ['a'] = 12, ['T'] = 13, ['t'] = 13, ['E'] = 14,
    ['e'] = 14, [255] = 0,
};

int letter_score(const char letter) {
  if (letter == ' ')
    return 8;
  if (!isalpha(letter))
    return -1;
  return english_scores[letter];
}

int english_score(const Buffer phrase) {
  int score = 0;
  for (size_t i = 0; i < phrase.size; ++i) {
    score += letter_score(phrase.content[i]);
  }
  return score;
}

typedef struct BruteforceResult {
  int score;
  Buffer buffer;
} BruteforceResult;

BruteforceResult bruteforce_xor(Buffer phrase) {
  BruteforceResult result = (BruteforceResult){
      .buffer = new_buffer(phrase.size),
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

int main(void) {
  int max_score = 0;
  FILE *f = fopen("4.txt", "r");
  char buf[256];
  while (fgets(buf, 255, f)) {
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    BruteforceResult br = bruteforce_xor(decode_hex(buf));
    if (br.score > max_score) {
      max_score = br.score;
      printf("%s - %2d - %s\n", buf, br.score, encode_ascii(br.buffer));
    }
  }
  fclose(f);
  return 0;
}
