#include "./utils.h"
#include <stdio.h>
#include <string.h>

void test(void) {
  const char test_hex_input[] =
      "49276d206b696c6c696e6720796f757220627261696e206c696b65"
      "206120706f69736f6e6f7573206d757368726f6f6d";

  const char test_base64_output[] =
      "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t";
  Buffer decoded = decode_hex(test_hex_input);
  char *encoded = encode_base64(decoded);
  if (strcmp(encoded, test_base64_output) != 0) {
    printf("ERROR: failed to compare.\n");
    exit(1);
  }
  free(encoded);
  free(decoded.content);
}

int main(int argc, char *argv[]) {
  test();
  if (argc > 1) {
    Buffer decoded = decode_hex(argv[1]);
    puts(encode_base64(decoded));
  }
  return 0;
}
