#!/usr/bin/env gawk -f
BEGIN { RS=","; FS="-" }
{
    for (num = $1; num <= $2; num++) {
        lo2 = int(length(num)/2)
        if (substr(num,0,lo2) == substr(num, lo2+1)) {
            part1 += num
        }
    }
}
END { print "Part 1: "part1 }
