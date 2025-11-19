#include "./utils.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  puts(encode_hex(
      xor_buffers(decode_hex("1c0111001f010100061a024b53535009181c"),
                  decode_hex("686974207468652062756c6c277320657965"))));
  return 0;
}
