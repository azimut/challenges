BEGIN {
    for(i=0;i<split("black brown red orange yellow green blue violet grey white",colors);i++)
        c2n[colors[i+1]] = i
}

{
    if ((!($1 in c2n)) || (!($2 in c2n)) || (!($3 in c2n)))
        abort()
    ohms = (c2n[$1] * 10 + c2n[$2]) * (10^c2n[$3])
    if (ohms >= 1e9) print (ohms/1e9), "gigaohms"
    else if (ohms >= 1e6) print (ohms/1e6), "megaohms"
    else if ((ohms >= 1e3) && (!is_float(ohms/1e3))) print (ohms/1e3), "kiloohms"
    else print ohms, "ohms"
}

function is_float(n) { return int(n) != n }
function abort() { print "whops!"; exit 1; }
