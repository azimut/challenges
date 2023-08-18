#!/bin/python3
# https://www.hackerrank.com/challenges/between-two-sets/problem



# The elements of the FIRST ARRAY are all factors of the integer being considered
# The integer being considered is a factor of all elements of the SECOND ARRAY
def getTotalX(a, b):
    count = 0
    for i in range(1, max(b)+1):
        if all(x % i == 0 for x in b) and all(i % x == 0 for x in a):
            count += 1
    return count


def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(getTotalX([2,6], [24,36]), 2, ([2,6], [24,36]))
    test(getTotalX([2,4], [16,32,96]), 3, ([2,4], [16,32,96]))
    test(getTotalX([1], [100]), 9, ([1], [100]))
