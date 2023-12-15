{
    count = u = cw = cd = cu = 0
    for (i = 1; i <= split($1,_springs,""); i++)
        switch (_springs[i]) {
        case "." : cw++; SPR_WORKING = "."; break
        case "#" : cd++; SPR_DAMAGED = "#"; break
        case "?" : cu++; SPR_UNKNOWN = "?"; unknowns[++u] = i; break
        }
    nunknowns = length(unknowns)
    npermutations = 2^nunknowns
    for (i = 1; i <= npermutations; i++) { # generate "?" permutations
        for (j = 1; j <= nunknowns; j++)
            _springs[unknowns[j]] = and(rshift(i,j-1),1) ? "#" : "."
        generated = ""
        for (idx in _springs) generated = generated _springs[idx] # join
        if (isValid(generated, $2)) count++
    }
    sum += count
    printf "%4d | %2d %2d %2d | %7d = %2d | %d\n", NR, cw, cd, cu, cache_springs_hit, cache_dgroups_hit, count
    delete _springs; delete unknowns; delete cache_dgroups
}
END { print "sum = "sum}
function isValid(    ogsprings, dgroups, _tmp, i, s) {
    gsub(/[\\.]+/,".",ogsprings) # squashes repeated dots

    if (ogsprings in cache_springs) cache_springs_hit++
    else for (i = 1; i <= split(ogsprings, _tmp, SPR_WORKING); i++)
             if (_tmp[i] != "")
                 cache_springs[ogsprings][++s] = length(_tmp[i])

    if (dgroups in cache_dgroups) cache_dgroups_hit++
    else for (i = 1; i <= split(dgroups, _tmp, ","); i++)
             cache_dgroups[dgroups][i] = _tmp[i]

    if (length(cache_springs[ogsprings]) != length(cache_dgroups[dgroups]))
        return 0

    for (i in cache_springs[ogsprings]) # we already know they are of =length
        if (cache_springs[ogsprings][i] != cache_dgroups[dgroups][i])
            return 0
    return 1
}
