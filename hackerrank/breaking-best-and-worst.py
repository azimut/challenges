#!/usr/bin/env python


# https://www.hackerrank.com/challenges/breaking-best-and-worst-records/problem?isFullScreen=true

def breakingRecords(scores):
    nmin = nmax = 0
    season_max = season_min = scores[0]
    for score in scores:
        if score > season_max:
            nmax += 1
            season_max = score
        if score < season_min:
            nmin += 1
            season_min = score
    return [nmax, nmin]


if __name__ == '__main__':
    print(breakingRecords([10, 5, 20, 20, 4, 5, 2, 25, 1]))
