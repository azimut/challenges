#!/usr/bin/env python3

# https://www.hackerrank.com/challenges/the-birthday-bar/problem

def birthday(s, d, m):
    result = 0
    for i in range(len(s)):
        slice = s[i:i+m]
        if len(slice) == m and sum(slice) == d:
            result += 1
    return result


if __name__ == '__main__':
    result = birthday([1, 2, 1, 3, 2], 3, 2)
    print(result == 2, result)
    result = birthday([2, 2, 1, 3, 2], 4, 2)
    print(result == 2, result)
    result = birthday([2, 5, 1, 3, 4, 4, 3, 5, 1, 1, 2, 1, 4, 1, 3, 3, 4, 2, 1], 18, 7)
    print(result == 3, result)
