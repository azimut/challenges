#!/usr/bin/env python

def solve(lst):
    return sorted(lst)[-3:]


if __name__ == '__main__':
    print(solve([141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]))
