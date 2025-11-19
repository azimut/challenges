#ifndef UTILS_H
#define UTILS_H

#include <stdint.h>
#include <stdlib.h>

typedef struct Buffer {
  uint8_t *content;
  size_t size;
} Buffer;

Buffer new_buffer(size_t size);
Buffer xor_buffers(Buffer a, Buffer b);

char *encode_base64(Buffer buffer);

Buffer decode_hex(const char *hex);
char *encode_hex(Buffer buffer);

#endif /* UTILS_H */
