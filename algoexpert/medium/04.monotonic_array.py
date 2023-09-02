#!/usr/bin/env python3

def solve_naive(arr):
    diff = []
    if len(arr) == 1:
        return True
    for i in range(len(arr)-1):
        diff.append(arr[i]-arr[i+1])
    return all([x >= 0 for x in diff]) \
        or all([x <= 0 for x in diff])


def solve_naive2(arr):
    diff = []
    if len(arr) == 1:
        return True
    for i in range(len(arr)-1):
        diff.append(arr[i]-arr[i+1])
    for i in range(len(diff)):
        a = arr[i]
        b = arr[i+1]
        if (not ((a >= 0 and b >= 0) or (a <= 0 and b <= 0))):
            return False
    return True


def solve_ae1(arr):
    if len(arr) <= 2:
        return True
    direction = arr[1] - arr[0]
    for i in range(2, len(arr)):
        if direction == 0:
            direction = arr[i] - arr[i-1]
            continue
        if breaksDirection(direction, arr[i-1], arr[i]):
            return False
    return True


def breaksDirection(direction, previousInt, currentInt):
    difference = currentInt - previousInt
    if direction > 0:  # we know != 0 due how we call it
        return difference < 0
    return difference > 0


def solve_ae2(arr):
    isNonDecreasing = True
    isNonIncreasing = True
    for i in range(1, len(arr)):
        if arr[i] < arr[i-1]:
            isNonDecreasing = False
        if arr[i] > arr[i-1]:
            isNonIncreasing = False
    return isNonIncreasing or isNonDecreasing


if __name__ == '__main__':
    input = [-1, -5, -10, -1100, -1100, -1101, -1102, -9001]
    print(solve_naive(input))
    print(solve_naive2(input))
    print(solve_ae1(input))
    print(solve_ae2(input))
