#include <stdio.h>
#include <string.h>

int main(void) {
  int input[] = {141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7};
  int largest[3];
  int tmp;
  memset(largest, 0, sizeof(int) * 3);
  for (int i = 0; i < sizeof(input) / sizeof(int); ++i) {
    for (int j = 2; j >= 0; --j) {
      if (input[i] > largest[j]) {
        // shift places
        if (j > 0) {
          tmp = largest[1];
          largest[0] = tmp;
          if (j == 2)
            largest[1] = largest[2];
        }
        largest[j] = input[i];
        break;
      }
    }
  }
  printf("[%d,%d,%d]\n", largest[0], largest[1], largest[2]);
  return 0;
}
