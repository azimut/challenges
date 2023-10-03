#!/usr/bin/env python

def solve_ae_boyer(nums):
    res = nums[0]
    count = 0
    for n in nums:
        # if n == res:
        #     count += 1
        # else:
        #     count -= 1
        # count = count + 1 if n == res else count - 1
        if count == 0:
            res = n
        count += +1 if n == res else -1
    return res


# O(n) time
# O(n) space
def solve_ae(nums):
    count = {}
    res, maxCount = 0, 0
    for n in nums:
        count[n] = 1 + count.get(n, 0)
        res = n if count[n] > maxCount else res
        maxCount = max(count[n], maxCount)
    return res

# O(n) time
# O(n) space
def solve(nums):
    counts = {}
    for n in nums:
        counts[n] = 1 + counts.get(n, 0)
        # counts[n] = counts[n] + 1 if n in counts else 1
        # counts[n] = 1 if n not in counts else counts[n] + 1
        # counts[n] = counts.setdefault(n, 0) + 1
    max_key = -1
    max_value = 0
    for k in counts.keys():
        if counts[k] > max_value:
            max_key = k
            max_value = counts[k]
    return max_key

if __name__ == '__main__':
    print(solve([3, 2, 3]) == 3)
    print(solve([2, 2, 1, 1, 1, 2, 2]) == 2)
    print(solve_ae([3, 2, 3]) == 3)
    print(solve_ae([2, 2, 1, 1, 1, 2, 2]) == 2)
    print(solve_ae_boyer([3, 2, 3]) == 3)
    print(solve_ae_boyer([2, 2, 1, 1, 1, 2, 2]) == 2)
