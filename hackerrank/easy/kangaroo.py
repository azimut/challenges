#!/bin/python3
# https://www.hackerrank.com/challenges/kangaroo/problem?isFullScreen=true

import os

# x1 + v1 * X     = x2 + v2 * X
# x1 - x2         = v2 * X - v1 * X
# x1 - x2         = (v2 - v1) * X
# (x1-x2)/(v2-v1) = X

def kangaroo(x1, v1, x2, v2):
    if x1 == x2: return "YES"
    if v1 == v2: return "NO"
    diff = (x1 - x2) / (v2 - v1)
    return "YES" if diff % 1 == 0 and diff > 0 else "NO"

# NOTE: errors with, due python max recursion is 1000
# "RecursionError: maximum recursion depth exceeded while calling a Python object"
#
# def kangaroo(x1, v1, x2, v2):
#     if x1 == x2:
#         return "YES"
#     if (x1 > x2 and v1 >= v2) or (x1 < x2 and v1 <= v2):
#         return "NO"
#     return kangaroo(x1+v1, v1, x2+v2, v2)

def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(kangaroo(2, 1, 1, 2), "YES", (2, 1, 1, 2))
    test(kangaroo(0, 3, 4, 2), "YES", (0, 3, 4, 2))
    test(kangaroo(0, 2, 5, 3), "NO", (0, 2, 5, 3))
    test(kangaroo(43, 2, 70, 2), "NO", (43, 2, 70, 2))
    test(kangaroo(1817, 9931, 8417, 190), "NO", (1817, 9931, 8417, 190))
    test(kangaroo(2081, 8403, 9107, 8400), "YES", (2081, 8403, 9107, 8400))
    test(kangaroo(21, 6, 47, 3), "NO", (21, 6, 47, 3))
