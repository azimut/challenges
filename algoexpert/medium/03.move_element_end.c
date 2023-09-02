#include <stdbool.h>
#include <stdio.h>

void swap(int xs[], int i, int j) {
  int tmp = xs[j];
  xs[j] = xs[i];
  xs[i] = tmp;
}

void echo(int xs[], int length) {
  for (int i = 0; i < length; ++i)
    printf("%d ", xs[i]);
  printf("\n");
}

// O(??)
void solve_naive(int numbers[], int length, int target) {
  int iter = 0;
  for (int i = length - 1; i > 0; --i) { // from the end
    if (numbers[i] == target)
      continue;
    for (int j = 0; j < i; ++j) { // from the beginning
      iter++;
      if (numbers[j] == target) {
        swap(numbers, i, j);
        break;
      }
    }
  }
  printf("iter = %d\n", iter);
}

// O(n) time
// O(1) space
void solve_blind(int numbers[], int length, int target) {
  int left = 0, right = length - 1;
  int iter = 0;
  while (left < right) {
    iter++;
    if (numbers[right] == target) {
      right--;
      continue;
    }
    if (numbers[left] != target) {
      left++;
      continue;
    }
    swap(numbers, left, right);
    right--;
    left++;
  }
  printf("iter = %d\n", iter);
}

// O(n)
// O(1)
void solve_ae(int numbers[], int length, int target) {
  int left = 0, right = length - 1;
  while (left < right) {
    while (left < right && numbers[right] == target)
      right--;
    if (numbers[left] == target)
      swap(numbers, right, left);
    left++;
  }
}

int main() {
  int input[] = {2, 1, 2, 2, 2, 3, 4, 2};
  int length = sizeof(input) / sizeof(int);
  echo(input, length);
  solve_naive(input, length, 2);
  echo(input, length);

  printf("\n\n");

  int input2[] = {2, 1, 2, 2, 2, 3, 4, 2};
  echo(input2, length);
  solve_blind(input2, length, 2);
  echo(input2, length);

  printf("\n\n");

  int input3[] = {2, 1, 2, 2, 2, 3, 4, 2};
  echo(input3, length);
  solve_ae(input3, length, 2);
  echo(input3, length);

  return 0;
}
