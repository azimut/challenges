#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// reverse string, and then strcmp()
// O(n) time
// O(n) space
bool is_palindrome(char *word) {
  bool result = false;
  char *reversed = (char *)malloc(strlen(word) * sizeof(char));
  for (int i = strlen(word) - 1, j = 0; i >= 0; i--, j++) {
    reversed[j] = word[i];
  }
  if (strcmp(word, reversed) == 0)
    result = true;
  free(reversed);
  return result;
}

// O(n) time
// O(n) space
bool is_palindrome_rec(char *word) {
  size_t length = strlen(word);
  if (length < 2)
    return true;
  if (word[0] != word[length - 1])
    return false;
  char new_word[length - 1];
  memset(new_word, 0, length - 1);
  strncpy(new_word, &word[1], length - 2);
  // printf("%s\n", new_word);
  return is_palindrome_rec(new_word);
}

bool is_palindrome_pointers(char *word) {
  int start = 0;
  int end = strlen(word) - 1;
  while (start <= end) {
    if (word[start] != word[end])
      return false;
    start++;
    end--;
  }
  return true;
}

void print_result(char *word, bool (*callback)(char *)) {
  bool result = callback(word);
  printf("\"%s\" %s a palindrome\n", word, result ? "is" : "is NOT");
}

int main() {
  print_result("abecedario", is_palindrome);
  print_result("amanaplanacanalpanama", is_palindrome);
  printf("\n");
  print_result("abecedario", is_palindrome_rec);
  print_result("amanaplanacanalpanama", is_palindrome_rec);
  printf("\n");
  print_result("abecedario", is_palindrome_pointers);
  print_result("amanaplanacanalpanama", is_palindrome_pointers);
  return 0;
}
