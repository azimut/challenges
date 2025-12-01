#!/usr/bin/gawk -f
BEGIN { dial = 50 }
/L/ { dial -= strtonum(substr($0,2)) }
/R/ { dial += strtonum(substr($0,2)) }
{
    dial = ((dial%100)+100)%100
    if (dial == 0)
        zeros++
}
END { print zeros }
