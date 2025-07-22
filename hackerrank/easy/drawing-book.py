#!/bin/python3
# https://www.hackerrank.com/challenges/drawing-book/problem?isFullScreen=true
# return an INTEGER. -- min num of pages to turn, from end or beginning
#  1. INTEGER n -- book pages
#  2. INTEGER p -- arrival page

import math

# INCOMPLETE

def pageCount(n, p):
    from_end = 1 if n == p else math.ceil(n/p)
    from_start = p//2
    print(f"{n=} {p=} {from_start=} {from_end=}")
    return min(from_end, from_start)


def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(pageCount(5, 3), 1, (5, 3))
    test(pageCount(6, 2), 1, (6, 2))
    test(pageCount(5, 4), 0, (5, 4))
