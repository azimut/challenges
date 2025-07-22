#include <assert.h>
#include <stdio.h>
#include <string.h>

// INCOMPLETE

char caesar_char(char input, int key) {
  assert(input >= 'a' && input <= 'z');
  char new = input + key;
  if (new > 'z') {
    new = new - ('z' - 'a' + 1);
  }
  return new;
}

void caesar(const char *input, char *output, int key) {
  memset(output, '\0', sizeof(char) * 1000);
  for (size_t i = 0; input[i] != '\0'; ++i) {
    output[i] = caesar_char(input[i], key);
  };
}

void caesar_abcdario(const char *input, char *output, int key) {
  memset(output, '\0', sizeof(char) * 1000);
  static const char *abcedario = "abcdefghijklmnopqrstvwuxyz";
  for (size_t i = 0; input[i] != '\0'; ++i) {
    output[i] = abcedario[(i + key) % 26];
  }
}

int main(void) {
  char *expected;
  char got[1000];

  expected = "bcdef";
  caesar("abcde", got, 1);
  if (strcmp(expected, got) != 0) {
    printf("got `%s`, but expected `%s`\n", got, expected);
    return 1;
  }

  expected = "abcde";
  caesar("abcde", got, 26);
  if (strcmp(expected, got) != 0) {
    printf("got `%s`, but expected `%s`\n", got, expected);
    return 1;
  }

  expected = "bcdef";
  caesar_abcdario("abcde", got, 1);
  if (strcmp(expected, got) != 0) {
    printf("got `%s`, but expected `%s`\n", got, expected);
    return 1;
  }

  expected = "abcde";
  caesar_abcdario("abcde", got, 26);
  if (strcmp(expected, got) != 0) {
    printf("got `%s`, but expected `%s`\n", got, expected);
    return 1;
  }

  return 0;
}
