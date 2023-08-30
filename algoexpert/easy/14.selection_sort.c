#include <stdio.h>

void swap(int numbers[], int i, int j) {
  int tmp = numbers[j];
  numbers[j] = numbers[i];
  numbers[i] = tmp;
}

// iter = 27
void selection_sort_day1(int numbers[], int length) {
  int minidx = 0;
  int iter = 0;
  for (int uidx = 0; uidx < length; ++uidx) { // decreasing sizes of unsorted
    for (int u = uidx; u < length; ++u) {     // this unsorted
      printf("iter = %d\n", iter++);
      if (numbers[u] < numbers[minidx])
        minidx = u;
    }
    swap(numbers, uidx, minidx);
  }
}

// iter = 20
void selection_sort_ae(int numbers[], int length) {
  int iter = 0, curr_idx = 0, small_idx = 0;
  while (curr_idx < length - 1) {
    small_idx = curr_idx;
    for (int i = curr_idx + 1; i < length; ++i) {
      printf("iter = %d\n", iter++);
      if (numbers[small_idx] > numbers[i])
        small_idx = i;
    }
    swap(numbers, curr_idx, small_idx);
    curr_idx++;
  }
}

int main(void) {
  int numbers[] = {8, 5, 2, 9, 5, 6, 3};
  int length = sizeof(numbers) / sizeof(int);
  selection_sort_day1(numbers, length);
  for (int i = 0; i < length; ++i)
    printf("%d ", numbers[i]);

  int numbers2[] = {8, 5, 2, 9, 5, 6, 3};
  int length2 = sizeof(numbers2) / sizeof(int);
  selection_sort_ae(numbers2, length2);
  for (int i = 0; i < length2; ++i)
    printf("%d ", numbers2[i]);

  return 0;
}
