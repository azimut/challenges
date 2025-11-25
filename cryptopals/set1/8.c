#include "./utils.h"
#include <stdio.h>
#include <string.h>

int main(void) {
  FILE *fp = fopen("8.txt", "r");
  char *line = NULL;
  size_t linesize;
  size_t read_size = 0;
  while ((read_size = getline(&line, &linesize, fp)) != -1) {
    line[read_size - 1] = '\0';
    puts(line);
    Buffer hexline = decode_hex(line);
    if (buffer_english_score(hexline) > 100) {
      puts(encode_ascii(hexline));
    }
    buffer_free(hexline);
  }
  fclose(fp);
  return 0;
}
