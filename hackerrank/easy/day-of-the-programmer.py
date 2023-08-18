#!/bin/python3
# https://www.hackerrank.com/challenges/day-of-the-programmer/problem

def is_leap(year):
    if year < 1918:
        return year % 4 == 0
    else:
        return (year % 400 == 0) or (year % 4 == 0 and year % 100 != 0)

def dayOfProgrammer(year):
    if year == 1918: return "26.09.1918"
    return f"12.09.{year}" if is_leap(year) else f"13.09.{year}"


def test(got, expected, args):
    if got != expected:
        print(f"got {got}, but expected {expected} with {args}")


if __name__ == '__main__':
    test(dayOfProgrammer(1918),"26.09.1918",(1918))
    test(dayOfProgrammer(1800),"12.09.1800",(1800))
    test(dayOfProgrammer(2016),"12.09.2016",(2016))
    test(dayOfProgrammer(2017),"13.09.2017",(2017))
    test(dayOfProgrammer(1984),"12.09.1984",(1984))
