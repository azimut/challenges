#!/bin/python3
# https://www.hackerrank.com/challenges/sock-merchant/

def sockMerchant(_, colors):
    n_pairs = 0
    counter = {}
    for color in colors:
        counter[color] = counter.setdefault(color, 0) + 1
    for _, v in counter.items():
        n_pairs += v // 2
    return n_pairs

# https://www.hackerrank.com/challenges/sock-merchant/problem?isFullScreen=true
def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(sockMerchant(7, [1, 2, 1, 2, 1, 3, 2]), 2, (7, [1, 2, 1, 2, 1, 3, 2]))
    test(sockMerchant(9, [10, 20, 20, 10, 10, 30, 50, 10, 20]), 3, (9, [10, 20, 20, 10, 10, 30, 50, 10, 20]))
