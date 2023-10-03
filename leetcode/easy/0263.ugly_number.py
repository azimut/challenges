#!/usr/bin/env python

def solve_ae(n):
    if n <= 0: return False
    for p in [2, 3, 5]:
        while n % p == 0:
            n = n // p
    return n == 1

def solve(n):
    print(f"=> {n}")
    if n <= 0: return False
    if n == 1: return True
    if n % 2 == 0: return solve(n//2)
    if n % 3 == 0: return solve(n//3)
    if n % 5 == 0: return solve(n//5)
    return False


if __name__ == '__main__':
    print(solve(6) == True)
    print(solve(8) == True)
    print(solve(14) == False)
    print(solve_ae(6) == True)
    print(solve_ae(8) == True)
    print(solve_ae(14) == False)
