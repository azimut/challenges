#!/usr/bin/env python

def add(arr, n):
    arr.reverse()
    i = 0
    while n > 0:
        if i < len(arr):
            plusmod10 = arr[i] + (n % 10)
            arr[i] = plusmod10 % 10
            n = n // 10
            n += plusmod10 // 10
            i += 1
        else:
            arr.append(n)
            n = n // 10
    arr.reverse()
    return arr


if __name__ == '__main__':
    print(add([1, 2, 3], 4))
    print(add([1, 2, 7], 4))
    print(add([1, 2, 7], 1000))
