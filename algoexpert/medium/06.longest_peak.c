#include <stdio.h>

int longest_peak_split(int *numbers, int length) {
  int peaks[length];
  int npeaks = 0;
  for (int i = 1; i < length - 1; ++i)
    if (numbers[i] > numbers[i - 1] && numbers[i] > numbers[i + 1])
      peaks[npeaks++] = i;

  int maxlength = -1, currentlength;
  int j;
  for (int i = 0; i < npeaks; ++i) {
    currentlength = 3;

    j = peaks[i] - 1;
    while (numbers[j] > numbers[j - 1] && j-- >= 0)
      currentlength++;

    j = peaks[i] + 1;
    while (numbers[j] > numbers[j + 1] && j++ <= length)
      currentlength++;

    if (currentlength > maxlength)
      maxlength = currentlength;
  }

  return maxlength;
}

int longest_peak(int *numbers, size_t length) {
  int maxlength = -1, currentlength;
  size_t j;
  for (size_t i = 1; i < length - 1; ++i)
    if (numbers[i] > numbers[i - 1] && numbers[i] > numbers[i + 1]) {
      currentlength = 3;

      j = i - 1;
      while (numbers[j] > numbers[j - 1] && j-- > 0)
        currentlength++;

      j = i + 1;
      while (numbers[j] > numbers[j + 1] && j++ < length)
        currentlength++;

      if (currentlength > maxlength)
        maxlength = currentlength;

      i = j - 1; // we move i forward to the end of our peak
    }
  return maxlength;
}

int main() {
  int input[13] = {1, 2, 3, 3, 4, 0, 10, 6, 5, -1, -3, 2, 3};
  printf("Longest peak is of length: %d\n", longest_peak(input, 13));
  printf("Longest peak is of length: %d\n", longest_peak_split(input, 13));
  return 0;
}
