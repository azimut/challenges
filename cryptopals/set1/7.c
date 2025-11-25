#include "./utils.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  char *raw_contents = read_file_as_oneline("7.txt");
  Buffer contents = decode_base64(raw_contents);
  unsigned char *decrypted = aes_decrypt(contents, "YELLOW SUBMARINE");
  puts((char *)decrypted);
  free(decrypted);
  free(contents.content);
  free(raw_contents);
  return 0;
}
