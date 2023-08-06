#!/usr/bin/env python

import timeit

# https://www.hackerrank.com/challenges/kangaroo/problem

# = Runtime Error
# = RecursionError: maximum recursion depth exceeded in comparison
# def kangaroo(x1, v1, x2, v2):
#     if x1 == x2 or x1+v1 == x2+v2: return "YES"
#     if x1  > x2: return "NO"
#     if v1  < v2: return "NO"
#     return kangaroo(x1+v1, v1, x2+v2, v2)

def kangaroo(x1, v1, x2, v2):
    return "NO"


if __name__ == '__main__':
    result = kangaroo(2, 1, 1, 2)
    print(result == "YES", result)
    result = kangaroo(0, 2, 5, 3)
    print(result == "NO", result)
    result = kangaroo(0, 3, 4, 2)
    print(result == "YES", result)
    result = kangaroo(43, 2, 70, 2)
    print(result == "NO", result)
