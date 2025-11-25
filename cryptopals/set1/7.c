#include "./utils.h"
#include <assert.h>
#include <openssl/evp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char *decrypt(Buffer cipherbuffer, char *key) {
  assert(16 == strlen(key));

  EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
  EVP_DecryptInit_ex(ctx, EVP_aes_128_ecb(), NULL, (unsigned char *)key, NULL);
  EVP_CIPHER_CTX_set_padding(ctx, 0);

  unsigned char *decrypted = calloc(cipherbuffer.size, sizeof(unsigned char));
  int decrypt_len1, decrypt_len2;
  EVP_DecryptUpdate(ctx, decrypted, &decrypt_len1, cipherbuffer.content,
                    cipherbuffer.size);
  EVP_DecryptFinal_ex(ctx, decrypted + decrypt_len1, &decrypt_len2);
  printf("%d + %d = %d\n", decrypt_len1, decrypt_len2,
         decrypt_len1 + decrypt_len2);
  decrypted[decrypt_len1 + decrypt_len2] = '\0';
  EVP_CIPHER_CTX_free(ctx);

  return decrypted;
}

int main(void) {
  char *raw_contents = read_file_as_oneline("7.txt");
  Buffer contents = decode_base64(raw_contents);
  unsigned char *decrypted = decrypt(contents, "YELLOW SUBMARINE");
  puts((char *)decrypted);
  free(decrypted);
  free(contents.content);
  free(raw_contents);
  return 0;
}
