#include "./utils.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define TEST_INPUT                                                             \
  "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

bool is_printable(const char letter) {
  return (letter >= ' ' && letter <= '~');
}
bool is_vowel(const char letter) {
  return (letter == 'A' || letter == 'a' || letter == 'E' || letter == 'e' ||
          letter == 'I' || letter == 'i' || letter == 'O' || letter == 'o' ||
          letter == 'U' || letter == 'u');
}
bool is_alpha(const char letter) {
  return ((letter >= 'A' && letter <= 'Z') || (letter >= 'a' && letter <= 'z'));
}

bool is_printable_buffer(const Buffer buffer) {
  for (size_t i = 0; i < buffer.size; ++i) {
    if (!is_printable((char)buffer.content[i])) {
      return false;
    }
  }
  return true;
}

uint count_vowels(const Buffer buffer) {
  uint n_vowels = 0;
  for (size_t i = 0; i < buffer.size; ++i)
    if (is_vowel((char)buffer.content[i]))
      n_vowels++;
  return n_vowels;
}

uint score_buffer(const Buffer buffer) {
  if (!is_printable_buffer(buffer))
    return 0;
  uint n_vowels = count_vowels(buffer);
  return n_vowels;
}

char *encode_ascii(const Buffer buffer) {
  char *result = calloc(buffer.size + 1, sizeof(char));
  for (size_t i = 0; i < buffer.size; ++i)
    result[i] = buffer.content[i];
  return result;
}

int main() {
  Buffer input = decode_hex(TEST_INPUT);
  for (size_t i = 0; i < 256; ++i) {
    Buffer tmp = xor_buffer(input, i);
    if (score_buffer(tmp) > 1) {
      char *decoded = encode_ascii(tmp);
      printf("%3d - %c - %2d - %s\n", i, i, score_buffer(tmp), decoded);
      free(decoded);
    }
    free(tmp.content);
  }
  puts(encode_ascii(input));
  return 0;
}
