#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char base64_alphabet[64] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

typedef struct Buffer {
  uint8_t *content;
  size_t size;
} Buffer;

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
