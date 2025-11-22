#ifndef UTILS_H
#define UTILS_H

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct Buffer {
  uint8_t *content;
  size_t size;
} Buffer;

Buffer buffer_from_string(const char *phrase);
Buffer buffer_new(size_t size);
bool buffer_equal(const Buffer a, const Buffer b);
Buffer xor_buffers(Buffer a, Buffer b);
Buffer xor_buffer(const Buffer src_buffer, uint8_t by);
Buffer repeating_xor(Buffer in, Buffer by);

int decode_base64_char(const char letter);
char *encode_base64(Buffer buffer);
char *encode_ascii(const Buffer buffer);
char *encode_hex(Buffer buffer);
Buffer decode_hex(const char *hex);
Buffer decode_base64(const char *encoded);

typedef struct BruteforceResult {
  int score;
  uint8_t key;
  Buffer buffer;
} BruteforceResult;

BruteforceResult bruteforce_xor(Buffer phrase);

#endif /* UTILS_H */
