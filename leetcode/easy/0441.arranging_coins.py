#!/usr/bin/env python

# INCOMPLETE

# O(n) time
def solve_brute(ncoins, height=1, npiles=0):
    if ncoins < height:
        return npiles
    return solve_brute(ncoins-height, height+1, npiles+1)

# O(log n) time
def solve_gauss_ae(n):
    l, r = 1, n
    res = 0
    while l <= r:
        mid = (l+r)//2
        coins = (mid/2) * (mid+1)
        if coins > n:
            r = mid - 1
        else:
            res = max(mid, res)
            l = mid + 1
    return res


if __name__ == '__main__':
    print(solve_brute(5) == 2)
    print(solve_gauss_ae(5) == 2)
