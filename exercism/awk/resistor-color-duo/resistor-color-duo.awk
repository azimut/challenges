BEGIN {
    for(;i<split("black brown red orange yellow green blue violet grey white", colors);)
        c2n[colors[i]] = i++
}
{
    if (($1 in c2n) && ($2 in c2n))
        print c2n[$1] * 10 + c2n[$2]
     else {
         print "invalid color"
         exit 1
    }
}
