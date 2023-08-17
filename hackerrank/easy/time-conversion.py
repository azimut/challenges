#!/bin/python3

import os

def timeConversion(s):
    hour = s[0:2]
    meridian = s[-2:]
    conversion = 12 if (meridian == "PM" and hour != "12") or (meridian == "AM" and hour == "12") else 0
    hours = (int(s[:2]) + conversion) % 24
    return f"{hours:02}{s[2:-2]}"


if __name__ == '__main__':
    got = timeConversion("12:01:00PM")
    expected = "12:01:00"
    print(f"{expected == got} expected: {expected} got: {got}")

    got = timeConversion("12:01:00AM")
    expected = "00:01:00"
    print(f"{expected == got} expected: {expected} got: {got}")

    got = timeConversion("07:05:45PM")
    expected = "19:05:45"
    print(f"{expected == got} expected: {expected} got: {got}")

    # fptr = open(os.environ['OUTPUT_PATH'], 'w')
    # s = input()
    # result = timeConversion(s)
    # fptr.write(result + '\n')
    # fptr.close()
