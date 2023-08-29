#include <stdbool.h>
#include <stdio.h>

int main() {
  int numbers[] = {8, 5, 2, 9, 5, 6, 3};
  int tmp, length = sizeof(numbers) / sizeof(int);
  bool swapped;
  for (int i = 0; i < length; ++i) {
    swapped = false;
    for (int j = i + 1; j < length; ++j)
      if (numbers[i] > numbers[j]) {
        tmp = numbers[j];
        numbers[j] = numbers[i];
        numbers[i] = tmp;
        swapped = true;
      }
    if (!swapped)
      break;
  }
  for (int i = 0; i < length; ++i)
    printf("[%d] = %d\n", i, numbers[i]);
  return 0;
}
