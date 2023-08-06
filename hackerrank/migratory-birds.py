#!/usr/bin/env python

# https://www.hackerrank.com/challenges/migratory-birds/problem
# Given an array of bird sightings where every element represents a bird
# type id, determine the id of the most frequently sighted type. If more
# than 1 type has been spotted that maximum amount, return the smallest
# of their ids.

import collections


def migratoryBirds(arr):
    counter = collections.Counter(arr)
    max_count = max(counter.values())
    counts_with_max = [x for x in counter.keys() if counter[x] == max_count]
    return min(counts_with_max)


if __name__ == '__main__':
    result = migratoryBirds([1, 4, 4, 4, 5, 3])
    print(result == 4, result)
