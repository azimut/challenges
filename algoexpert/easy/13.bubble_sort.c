#include <stdbool.h>
#include <stdio.h>

void swap(int xs[], int i, int j) {
  int tmp = xs[j];
  xs[j] = xs[i];
  xs[i] = tmp;
}

void bubble_sort(int numbers[], int length) {
  int top = length;
  int iter = 0;
  bool is_sorted = false;
  while (!is_sorted) {
    is_sorted = true;
    for (int i = 0; i < top - 1; ++i) {
      printf("iter = %d\n", iter++);
      if (numbers[i] > numbers[i + 1]) {
        swap(numbers, i, i + 1);
        is_sorted = false;
      }
    }
    top--;
  }
}

void bubble_sort_mine(int numbers[], int length) {
  int iter = 0;
  int top = length;
  bool swapped = false;
  for (int i = 0; i < top - 1; ++i) {
    printf("iter = %d\n", iter++);
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
}

int main() {
  int numbers[] = {8, 5, 2, 9, 5, 6, 3};
  int length = sizeof(numbers) / sizeof(int);
  bubble_sort_mine(numbers, length);
  for (int i = 0; i < length; ++i)
    printf("[%d] = %d\n", i, numbers[i]);

  printf("-----------\n");

  int numbers_bar[] = {8, 5, 2, 9, 5, 6, 3};
  bubble_sort(numbers_bar, 7);
  for (int i = 0; i < length; ++i)
    printf("[%d] = %d\n", i, numbers[i]);

  return 0;
}
