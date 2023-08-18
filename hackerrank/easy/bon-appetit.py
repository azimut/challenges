#!/bin/python3

def bonAppetit(bill, k, b):
    split_bill = b - (sum(bill)-bill[k])//2
    return "Bon Appetit" if split_bill == 0 else f"{split_bill:d}"


def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(bonAppetit([3, 10, 2, 9], 1, 12), "5", ([3, 10, 2, 9], 1, 12))
    test(bonAppetit([3, 10, 2, 9], 1, 7), "Bon Appetit", ([3, 10, 2, 9], 1, 7))
