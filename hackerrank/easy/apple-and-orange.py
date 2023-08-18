#!/bin/python3
# https://www.hackerrank.com/challenges/apple-and-orange/problem


def countApplesAndOranges(s, t, a, b, apples, oranges):
    x1 = sum(1 for dist in apples if a+dist >= s and a+dist <= t)
    x2 = sum(1 for dist in oranges if b+dist >= s and b+dist <= t)
    return f"{x1}\n{x2}"


def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(countApplesAndOranges(7, 10, 4, 12, [2, 3, -4], [3, -2, -4]), "1\n2", (7, 10, 4, 12, [2, 3, -4], [3, -2, -4]))
    test(countApplesAndOranges(7, 11, 5, 15, [-2, 2, 1], [5, -6]), "1\n1", (7, 11, 5, 15, [-2, 2, 1], [5, -6]))
