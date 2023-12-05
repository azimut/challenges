BEGIN    { categories[++cid] = "seed"; src=2; dst=1 }
/seeds:/ { for (i = 2; i <= NF; i++) seeds[++sid] = $i }
/map:/   { id = 0; categories[++cid] = substr($1, 4+index($1,"-to-")) }
/^[0-9]/ {
    id++
    mapping[categories[cid]][id]["range"] = $3
    mapping[categories[cid]][id]["source"] = $src
    mapping[categories[cid]][id]["destination"] = $dst
}
END {
    for (cid in categories) { # in order per category
        if (categories[cid] == "location") break # no next category
        for (sid in seeds) { # values to be converted
            newValue = seeds[sid]
            for (idx in mapping[categories[cid+1]]) {
                source      = mapping[categories[cid+1]][idx]["source"]
                range       = mapping[categories[cid+1]][idx]["range"]
                destination = mapping[categories[cid+1]][idx]["destination"]
                if (seeds[sid] >= source && seeds[sid] <= (source + range))
                    newValue = destination + (seeds[sid] - source)
            }
            seeds[sid] = newValue
        }
    }
    minLocation = 9999999999999999999999999999999 # hopefullly is big enough
    for (sid in seeds)
        minLocation = min(minLocation, seeds[sid])
    print "MIN: "minLocation
}
function min(    x,y) { return (x<y)?x:y  }
