#include "./utils.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

int count_bits(const char letter) {
  int count = 0;
  for (size_t i = 0; i < 8; ++i)
    count += letter >> i & 1;
  return count;
}

// TODO: account for missmatched lengths
int hamming_distance_buffer(const Buffer a, const Buffer b) {
  assert(a.size == b.size);
  int distance = 0;
  for (size_t i = 0; i < a.size; ++i)
    distance += count_bits(a.content[i] ^ b.content[i]);
  return distance;
}
int hamming_distance(const char *a, const char *b) {
  return hamming_distance_buffer(buffer_from_string(a), buffer_from_string(b));
}

Buffer decode_base64(const char *encoded) {
  Buffer result = buffer_new((strlen(encoded) * 8 - (strlen(encoded) * 2)) / 8);
  size_t ridx = 0;
  for (size_t i = 0; i < strlen(encoded); i += 4) {
    uint32_t tmp = 0;
    for (size_t j = i; j < i + 4; ++j) {
      tmp = (tmp << 6) | decode_base64_char(encoded[j]);
    }
    result.content[ridx++] = (tmp >> (2 * 8)) & 0xFF;
    if (encoded[i + 2] == '=') {
      result.size -= 2;
      break;
    }
    result.content[ridx++] = (tmp >> (1 * 8)) & 0xFF;
    if (encoded[i + 3] == '=') {
      result.size -= 1;
      break;
    }
    result.content[ridx++] = (tmp >> (0 * 8)) & 0xFF;
  }
  return result;
}

long get_filesize(const char *filename) {
  FILE *fp = fopen(filename, "rb");
  fseek(fp, 0, SEEK_END);
  long filesize = ftell(fp);
  fclose(fp);
  return filesize;
}

char *read_file_as_oneline(const char *filename) {
  char *result = calloc(get_filesize(filename), sizeof(char));
  size_t ridx = 0;
  FILE *fp = fopen(filename, "r");
  char buf[255] = {0}; // !
  while (fgets(buf, 255, fp)) {
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    strcpy(&result[ridx], buf);
    ridx += strlen(buf);
  };
  fclose(fp);
  return result;
}

float keysize_score(const Buffer buffer, const int keysize) {
  assert(keysize > 1);
  assert(buffer.size > (keysize * 2));
  Buffer a = buffer_new(keysize);
  Buffer b = buffer_new(keysize);
  for (size_t i = 0; i < keysize; ++i)
    a.content[i] = buffer.content[i];
  for (size_t i = keysize; i < keysize * 2; ++i)
    b.content[i - keysize] = buffer.content[i];
  int distance = hamming_distance_buffer(a, b);
  free(a.content);
  free(b.content);
  return (float)distance / (float)keysize;
}

int find_keysize(const Buffer buffer) {
  float min_score = 99999;
  int keysize = 2;
  for (size_t i = keysize; i <= 40; ++i) {
    float score = keysize_score(buffer, i);
    // printf("Keysize/Score - %2d - %f - %d\n", i, score, buffer.size);
    if (score < min_score) {
      min_score = score;
      keysize = i;
    }
  }
  return keysize;
}

int main(void) {
  // count bits test
  assert(5 == count_bits('O'));
  assert(4 == count_bits('c'));
  assert(3 == count_bits('C'));
  assert(1 == count_bits(1));
  // hamming distance test
  assert(37 == hamming_distance("this is a test", "wokka wokka!!!"));
  // encode tests
  assert(!strcmp("YWJj", encode_base64(buffer_from_string("abc"))));
  assert(!strcmp("YWJjZA==", encode_base64(buffer_from_string("abcd"))));
  assert(!strcmp("YWJjZGU=", encode_base64(buffer_from_string("abcde"))));
  assert(!strcmp("YWJjZGVm", encode_base64(buffer_from_string("abcdef"))));
  assert(!strcmp("YWJjZGVmZw==", encode_base64(buffer_from_string("abcdefg"))));
  // decode tests
  assert(!strcmp("YWJj", encode_base64(decode_base64("YWJj"))));
  assert(!strcmp("YWJjZA==", encode_base64(decode_base64("YWJjZA=="))));
  assert(!strcmp("YWJjZGU=", encode_base64(decode_base64("YWJjZGU="))));
  assert(!strcmp("YWJjZGVm", encode_base64(decode_base64("YWJjZGVm"))));
  assert(!strcmp("YWJjZGVmZw==", encode_base64(decode_base64("YWJjZGVmZw=="))));
  assert(equal_buffer(
      decode_base64(
          "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"),
      decode_hex("49276d206b696c6c696e6720796f757220627261696e206c696b652061207"
                 "06f69736f6e6f7573206d757368726f6f6d")));
  // decode file
  char *contents = read_file_as_oneline("6.txt");
  printf("Keysize: %d\n", find_keysize(decode_base64(contents)));
  assert(!strcmp(contents, encode_base64(decode_base64(contents))));
  FILE *f = fopen("6.txt", "r");
  fclose(f);
  // free(contents);
  return 0;
}
