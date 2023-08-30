#include <stdio.h>

void swap(int xs[], int i, int j) {
  int tmp = xs[j];
  xs[j] = xs[i];
  xs[i] = tmp;
}

// iter = 27
void insertion_sort_day1(int numbers[], int length) {
  int iter = 0;
  for (int i = 1; i < length; ++i)     // each number on the unsorted zone
    for (int j = i - 1; j >= 0; --j) { // against each number on the sorted zone
      if (numbers[i] < numbers[j]) {
        printf("iter = %d\n", iter++);
        swap(numbers, i, j);
        i = j;
      } else {
        break;
      }
    }
}

// iter = 11
void insertion_sort_ae(int numbers[], int length) {
  int iter = 0;
  for (int i = 1; i < length; ++i) {
    int j = i;
    while (j > 0 && numbers[j] < numbers[j - 1]) {
      printf("iter = %d\n", iter++);
      swap(numbers, j, j - 1);
      j--;
    }
  }
}

int main(void) {
  int input[] = {8, 5, 2, 9, 5, 6, 3};
  int length = sizeof(input) / sizeof(int);
  insertion_sort_day1(input, length);
  for (int i = 0; i < length; ++i)
    printf("[%d] = %d\n", i, input[i]);

  printf("-------\n");

  int input2[] = {8, 5, 2, 9, 5, 6, 3};
  int length2 = sizeof(input2) / sizeof(int);
  insertion_sort_ae(input2, length2);
  for (int i = 0; i < length2; ++i)
    printf("[%d] = %d\n", i, input2[i]);
  return 0;
}
