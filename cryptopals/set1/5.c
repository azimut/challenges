#include "./utils.h"
#include <stdio.h>
#include <string.h>

const char *input = "Burning 'em, if you ain't quick and nimble\n"
                    "I go crazy when I hear a cymbal";

const char *output = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2"
                     "a26226324272765272a282b2f20430a652e2c652a3124333a653e2b20"
                     "27630c692b20283165286326302e27282f";

Buffer repeating_xor(Buffer in, Buffer by) {
  Buffer result = new_buffer(in.size);
  for (size_t i = 0; i < in.size; ++i) {
    result.content[i] = in.content[i] ^ by.content[i % by.size];
  }
  return result;
}

Buffer from_string(const char *phrase) {
  Buffer result = new_buffer(strlen(phrase));
  for (size_t i = 0; i < strlen(phrase); ++i)
    result.content[i] = phrase[i];
  return result;
}

int main(void) {
  puts(encode_hex(repeating_xor(from_string(input), from_string("ICE"))));
  return 0;
}
