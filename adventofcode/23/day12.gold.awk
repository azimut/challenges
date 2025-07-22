# INCOMPLETE
{
    # ogone = $1; ogtwo = $2
    # for (i = 1; i <= 4; i++) {
    #     $1 = $1 "?" ogone
    #     $2 = $2 "," ogtwo
    # }
    count = u = cw = cd = cu = 0
    for (i = 1; i <= split($1,_springs,""); i++) {
        switch (_springs[i]) {
        case "." : cw++; SPR_WORKING = "."; break
        case "#" : cd++; SPR_DAMAGED = "#"; break
        case "?" : cu++; SPR_UNKNOWN = "?"; unknowns[++u] = i; break
        }
    }
    nunknowns = length(unknowns)
    npermutations = 2^nunknowns
    for (i = 1; i <= npermutations; i++) {
        for (j = 1; j <= nunknowns; j++)
            _springs[unknowns[j]] = and(rshift(i,j-1),1) ? "#" : "."
        generated = ""
        for (idx in _springs) generated = generated _springs[idx]
        if (isValid(generated, $2)) count++
    }
    sum += count
    printf "%4d | %2d %2d %2d | %7d %7d %d = %d\n", NR,
        cw, cd, cu,
        cache_springs_hit, cache_dgroups_hit, early_hit, count
    delete _springs; delete unknowns#; delete cache_dgroups
}
END { print "count = "sum }
function isValid(    ogsprings, dgroups, _tmp, i, s, nn) {
    gsub(/[\\.]+/,".",ogsprings) # squashes repeated dots
    # gsub(/^[\\.]+/,"",ogsprings)
    # gsub(/[\\.]+$/,"",ogsprings)
    if ((ogsprings,dgroups) in global_cache) {
        early_hit++
        return global_cache[ogsprings,dgroups]
    }

    if (ogsprings in cache_springs) cache_springs_hit++
    else {
        nn = split(ogsprings, _tmp, SPR_WORKING)
        for (i = 1; i <= nn; i++)
            if (_tmp[i] != "")
                cache_springs[ogsprings][++s] = length(_tmp[i])
    }

    if (dgroups in cache_dgroups) cache_dgroups_hit++
    else {
        nn = split(dgroups, _tmp, ",")
        for (i = 1; i <= nn; i++)
            cache_dgroups[dgroups][i] = _tmp[i]
    }

    if (length(cache_springs[ogsprings]) != length(cache_dgroups[dgroups])) {
        global_cache[ogsprings,dgroups] = 0
        return 0
    }
    for (i in cache_springs[ogsprings])
        if (cache_springs[ogsprings][i] != cache_dgroups[dgroups][i]) {
            global_cache[ogsprings,dgroups] = 0
            return 0
        }
    global_cache[ogsprings,dgroups] = 1
    return 1
}
