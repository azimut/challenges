#!/usr/bin/env python


def solve_ae(phrase, pattern):
    words = phrase.split()

    if len(words) != len(pattern):
        return False

    word2char = {}
    char2word = {}
    for c,w in zip(pattern, words):
        if c in char2word and char2word[c] != w:
            return False
        if w in word2char and word2char[w] != c:
            return False
        char2word[c] = w
        word2char[w] = c
    return True

def solve(phrase, pattern):
    words = phrase.split()

    if len(words) != len(pattern):
        return False

    word2char = {}
    char2word = {}
    for i in range(len(pattern)):
        word = words[i]
        char = pattern[i]
        if char in char2word:
            if char2word[char] != words[i] or word2char[word] != char:
                return False
        else:
            char2word[char] = word
            word2char[word] = char

    return True


if __name__ == '__main__':
    print(solve("dog cat cat dog", "abba"))
    print(solve_ae("dog cat cat dog", "abba"))
