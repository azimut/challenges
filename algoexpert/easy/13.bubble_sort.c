#include <stdbool.h>
#include <stdio.h>

void swap(int xs[], int i, int j) {
  int tmp = xs[j];
  xs[j] = xs[i];
  xs[i] = tmp;
}

int main() {
  int numbers[] = {8, 5, 2, 9, 5, 6, 3};
  int length = sizeof(numbers) / sizeof(int);
  int top = length;
  bool swapped = false;
  for (int i = 0; i < top - 1; ++i) {
    if (numbers[i] > numbers[i + 1]) {
      swap(numbers, i, i + 1);
      swapped = true;
    }
    if (i == top - 2 && swapped) {
      i = -1;
      top--;
      swapped = false;
    }
  }
  for (int i = 0; i < length; ++i)
    printf("[%d] = %d\n", i, numbers[i]);
  return 0;
}
