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
int hamming_distance(const char *a, const char *b) {
  assert(strlen(a) == strlen(b));
  int distance = 0;
  for (size_t i = 0; i < strlen(a); ++i)
    distance += count_bits(a[i] ^ b[i]);
  return distance;
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
  puts(encode_base64(decode_base64("YWJjZA==")));
  assert(!strcmp("YWJj", encode_base64(decode_base64("YWJj"))));
  assert(!strcmp("YWJjZA==", encode_base64(decode_base64("YWJjZA=="))));
  assert(!strcmp("YWJjZGU=", encode_base64(decode_base64("YWJjZGU="))));
  assert(!strcmp("YWJjZGVm", encode_base64(decode_base64("YWJjZGVm"))));
  assert(!strcmp("YWJjZGVmZw==", encode_base64(decode_base64("YWJjZGVmZw=="))));
  // decode file
  char *contents = read_file_as_oneline("6.txt");
  puts(contents);
  puts("---");
  puts(encode_base64(decode_base64(contents)));
  assert(!strcmp(contents, encode_base64(decode_base64(contents))));
  puts("---");
  puts(encode_hex(decode_base64(
      "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")));
  assert(equal_buffer(
      decode_base64(
          "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"),
      decode_hex("49276d206b696c6c696e6720796f757220627261696e206c696b652061207"
                 "06f69736f6e6f7573206d757368726f6f6d")));
  FILE *f = fopen("6.txt", "r");
  fclose(f);
  return 0;
}
