#!/usr/bin/env python

def solve_ae(s, t):
    mapST, mapTS = {}, {}
    for i in range(len(s)):
        c1, c2 = s[i], t[i]
        if (c1 in mapST and mapST[c1] != c2) or
           (c2 in mapTS and mapTS[c2] != c1):
            return False
        mapST[c1] = c2
        mapTS[c2] = c1
    return True


def solve(s, t):
    mapST, mapTS = {}, {}
    for c1, c2 in zip(s, t):
        if c1 in mapST and mapST[c1] != c2:
            return False
        if c2 in mapTS and mapTS[c2] != c1:
            return False
        mapST[c1] = c2
        mapTS[c2] = c1
    return True


if __name__ == '__main__':
    print(solve("egg", "add") == True)
    print(solve("foo", "bar") == False)
