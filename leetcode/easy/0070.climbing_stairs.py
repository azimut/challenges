#!/usr/bin/env python

# O(n) time
# O(1) space
def solve_dp(stairsteps):
    one, two = 1, 1
    for i in range(stairsteps-1):
        tmp = one
        one = one + two
        two = tmp
    return one


# O(2^n) time, since its height of the decision tree
def solve(stairsteps, steps=0):
    if steps == stairsteps:
        return 1
    if steps > stairsteps:
        return 0
    return solve(stairsteps, steps+1) \
         + solve(stairsteps, steps+2)


if __name__ == '__main__':
    print(solve(2) == 2)
    print(solve(3) == 3)
    print(solve(5) == 8)
    print()
    print(solve_dp(2) == 2)
    print(solve_dp(3) == 3)
    print(solve_dp(5) == 8)
