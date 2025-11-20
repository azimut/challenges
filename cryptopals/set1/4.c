#include "./utils.h"

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void) {
  // Now that the party is jumping
  int max_score = 0;
  FILE *f = fopen("4.txt", "r");
  char buf[256];
  while (fgets(buf, 255, f)) {
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    BruteforceResult br = bruteforce_xor(decode_hex(buf));
    if (br.score > max_score) {
      max_score = br.score;
      printf("%s - %2d - %s\n", buf, br.score, encode_ascii(br.buffer));
    }
  }
  fclose(f);
  return 0;
}
