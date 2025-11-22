#include "./utils.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

int count_bits(const char letter) {
  int count = 0;
  for (size_t i = 0; i < 8; ++i)
    count += letter >> i & 1;
  return count;
}

// TODO: account for missmatched lengths
int hamming_distance_buffer(const Buffer a, const Buffer b) {
  assert(a.size == b.size);
  int distance = 0;
  for (size_t i = 0; i < a.size; ++i)
    distance += count_bits(a.content[i] ^ b.content[i]);
  return distance;
}
int hamming_distance(const char *a, const char *b) {
  return hamming_distance_buffer(buffer_from_string(a), buffer_from_string(b));
}

long get_filesize(const char *filename) {
  FILE *fp = fopen(filename, "rb");
  fseek(fp, 0, SEEK_END);
  long filesize = ftell(fp);
  fclose(fp);
  return filesize;
}

char *read_file_as_oneline(const char *filename) {
  char *result = calloc(get_filesize(filename), sizeof(char));
  size_t ridx = 0;
  FILE *fp = fopen(filename, "r");
  char buf[255] = {0}; // !
  while (fgets(buf, 255, fp)) {
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    strcpy(&result[ridx], buf);
    ridx += strlen(buf);
  };
  fclose(fp);
  return result;
}

float keysize_score(const Buffer buffer, const int keysize) {
  assert(keysize > 1);
  assert(buffer.size > (keysize * 2));
  Buffer a = buffer_new(keysize);
  Buffer b = buffer_new(keysize);
  for (size_t i = 0; i < keysize; ++i)
    a.content[i] = buffer.content[i];
  for (size_t i = keysize; i < keysize * 2; ++i)
    b.content[i - keysize] = buffer.content[i];
  int distance = hamming_distance_buffer(a, b);
  free(a.content);
  free(b.content);
  return (float)distance / (float)keysize;
}

typedef struct KeysizeScore {
  float score;
  int keysize;
} KeysizeScore;

typedef struct KeysizeScores {
  KeysizeScore *scores;
  size_t size;
} KeysizeScores;

KeysizeScores new_scores(size_t size) {
  return (KeysizeScores){
      .scores = calloc(size, sizeof(KeysizeScore)),
      .size = size,
  };
}

int compare_keyscore(const void *a, const void *b) {
  const KeysizeScore *ascore = a;
  const KeysizeScore *bscore = b;
  return ascore->score - bscore->score;
}

KeysizeScores find_keysizes(const Buffer buffer) {
  KeysizeScores result = new_scores(39);
  for (size_t i = 2; i <= 40; ++i) {
    float score = keysize_score(buffer, i);
    // printf("Keysize/Score - %2d - %f - %d\n", i, score, buffer.size);
    result.scores[i - 2].keysize = i;
    result.scores[i - 2].score = score;
  }
  qsort(result.scores, result.size, sizeof(KeysizeScore), compare_keyscore);
  return result;
}

void crack_with(const Buffer input, const int key_size) {
  Buffer tmp_buffer = buffer_new(input.size / key_size);
  char *found_key = calloc(key_size + 2, sizeof(char));
  for (size_t kidx = 0; kidx < key_size; kidx++) {
    size_t a = 0;
    for (size_t jidx = kidx; jidx < input.size; jidx += key_size) {
      tmp_buffer.content[a++] = input.content[jidx];
    }
    BruteforceResult br = bruteforce_xor(tmp_buffer);
    /* puts(encode_ascii(tmp_buffer)); */
    /* printf("%d\n", tmp_buffer.size); */
    found_key[kidx] = br.key;
    free(br.buffer.content);
  }
  printf("[%2d] %s\n", key_size, found_key);
  free(found_key);
  free(tmp_buffer.content);
}

void crack(const Buffer input) {
  KeysizeScores prob_keys = find_keysizes(input);
  for (size_t i = 0; i < prob_keys.size; ++i) {
    crack_with(input, prob_keys.scores[i].keysize);
  }
  free(prob_keys.scores);
}

int main(void) {
  // count bits test
  assert(5 == count_bits('O'));
  assert(4 == count_bits('c'));
  assert(3 == count_bits('C'));
  assert(1 == count_bits(1));
  // hamming distance test
  assert(37 == hamming_distance("this is a test", "wokka wokka!!!"));
  // encode tests
  assert(!strcmp("YWJj", encode_base64(buffer_from_string("abc"))));
  assert(!strcmp("YWJjZA==", encode_base64(buffer_from_string("abcd"))));
  assert(!strcmp("YWJjZGU=", encode_base64(buffer_from_string("abcde"))));
  assert(!strcmp("YWJjZGVm", encode_base64(buffer_from_string("abcdef"))));
  assert(!strcmp("YWJjZGVmZw==", encode_base64(buffer_from_string("abcdefg"))));
  // decode tests
  assert(!strcmp("YWJj", encode_base64(decode_base64("YWJj"))));
  assert(!strcmp("YWJjZA==", encode_base64(decode_base64("YWJjZA=="))));
  assert(!strcmp("YWJjZGU=", encode_base64(decode_base64("YWJjZGU="))));
  assert(!strcmp("YWJjZGVm", encode_base64(decode_base64("YWJjZGVm"))));
  assert(!strcmp("YWJjZGVmZw==", encode_base64(decode_base64("YWJjZGVmZw=="))));
  assert(buffer_equal(
      decode_base64(
          "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"),
      decode_hex("49276d206b696c6c696e6720796f757220627261696e206c696b652061207"
                 "06f69736f6e6f7573206d757368726f6f6d")));
  // decode file
  char *contents = read_file_as_oneline("6.txt");
  // printf("Keysize: %d\n", find_keysize(decode_base64(contents)));
  KeysizeScores sc = find_keysizes(decode_base64(contents));
  for (size_t i = 0; i < sc.size; ++i) {
    printf("%d - %f\n", sc.scores[i].keysize, sc.scores[i].score);
  }
  assert(!strcmp(contents, encode_base64(decode_base64(contents))));
  Buffer decoded = decode_base64(contents);
  crack(decoded);
  puts(encode_ascii(
      repeating_xor(decode_base64(contents),
                    buffer_from_string("Terminator X: Bring the noise"))));
  return 0;
}
