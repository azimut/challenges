# hanukkah of data

home: https://hanukkah.bluebird.sh/5784/

## notes

### Day 5

#### jq

I give up. There isn't a way to run an expression just once for the whole execution. Everything on a *jq* program runs once per object. ANd today's problem involves at least 2 different sets member tests per input object. That is parsing 8k objects to obtain the set. On each one of the 200k input objects. 200000*8000=...

#### Awk

I guess I could do it on it. More precisely on *Gawk* to use ~FPAT~. But, having to manually parse 3 different files kind makes it lose his fun to the language. For example, I will need to get away from the implicit loop of awk and ONLY work in BEGIN. Not the end of the world but...

``` awk
BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
    while (getline < "data/5784/noahs-customers.csv") {
        print NF
    }
}
```
