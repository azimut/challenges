#include "./utils.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  puts(encode_hex(
      xor_buffers(decode_hex("1c0111001f010100061a024b53535009181c"),
                  decode_hex("686974207468652062756c6c277320657965"))));
  // encode_ascii
  //  
  puts(encode_ascii(decode_hex("1c0111001f010100061a024b53535009181c")));
  // hit the bull's eye
  puts(encode_ascii(decode_hex("686974207468652062756c6c277320657965")));
  // the kid don't play
  puts(encode_ascii(
      xor_buffers(decode_hex("1c0111001f010100061a024b53535009181c"),
                  decode_hex("686974207468652062756c6c277320657965"))));
  return 0;
}
