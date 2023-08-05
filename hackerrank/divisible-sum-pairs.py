#!/usr/bin/env python

# https://www.hackerrank.com/challenges/divisible-sum-pairs/problem?isFullScreen=true

def divisibleSumPairs(n, k, ar):
    pairs = 0
    for j in range(n-1, 0, -1):
        for i in range(j):
            if ((ar[i] + ar[j]) % k) == 0:
                pairs += 1
    return pairs


if __name__ == '__main__':
    print(divisibleSumPairs(6, 3, [1, 3, 2, 6, 1, 2]))
