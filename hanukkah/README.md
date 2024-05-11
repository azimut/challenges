# hanukkah of data

home: https://hanukkah.bluebird.sh/5784/

## notes

### Day 5

#### jq

I give up. There isn't a way to run an expression just once for the whole execution. Everything on a *jq* program runs once per object. And today's problem involves at least 2 different sets member tests per input object. Just to reduce the search space. That is parsing 8k objects to obtain the set. On each one of the 200k input objects. 200000*8000=...

#### Awk

It could be done...more precisely it could be done with *Gawk* using **FPAT** to define the csv parsing. But, having to manually parse 3 different files, kind of makes it not fun. For example, I will need to do the bookeeping of each file line processing on an explicit loop and limit my work to BEGIN. Not the end of the world but...

For example:

``` awk
BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
    while (getline < "data/5784/noahs-customers.csv") {
        print NF
    }
}
```

### Day 6

#### SQLite

Mostly straighforward. Once I dropped trying to lookup for someone that bought a "Noah's Jersey"... Speed wise, I tried subselects, JOINs and putting the condition on JOIN/ON/AND instead of WHERE. But neither showed better speed results.
