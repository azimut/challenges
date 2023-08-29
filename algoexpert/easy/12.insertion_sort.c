#include <stdio.h>

void swap(int xs[], int i, int j) {
  int tmp = xs[j];
  xs[j] = xs[i];
  xs[i] = tmp;
}

int main(void) {
  int input[] = {8, 5, 2, 9, 5, 6, 3};
  int length = sizeof(input) / sizeof(int);

  for (int i = 1; i < length; ++i)
    for (int j = i - 1; j >= 0; --j)
      if (input[i] < input[j]) {
        swap(input, i, j);
        i = j;
      } else {
        break;
      }

  for (int i = 0; i < length; ++i)
    printf("%d: %d\n", i, input[i]);

  return 0;
}
