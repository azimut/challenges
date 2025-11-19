#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
};

Buffer xor_buffer(Buffer a, Buffer b) {
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

int main(int argc, char *argv[]) {
  puts(encode_hex(
      xor_buffer(decode_hex("1c0111001f010100061a024b53535009181c"),
                 decode_hex("686974207468652062756c6c277320657965"))));
  return 0;
}
