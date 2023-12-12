{
    cache_springs_hit = cache_dgroups_hit = u = ca = cb = cc = 0
    for (i = 1; i <= split($1,rawrecord,""); i++) {
        switch (rawrecord[i]) {
        case "." : ca++; SPR_WORKING = "."; break
        case "#" : cb++; SPR_DAMAGED = "#"; break
        case "?" : cc++; SPR_UNKNOWN = "?"; unkpos[++u] = i; break
        }
        springs[NR][i] = rawrecord[i]
    }
    npositions = length(unkpos)
    npermutations = 2^npositions
    for (i = 1; i <= npermutations; i++) {
        for (j = 1; j <= npositions; j++)
            rawrecord[unkpos[j]] = and(rshift(i,j-1),1) ? "#" : "."
        generated = ""
        for (idx in rawrecord) generated = generated rawrecord[idx]
        print generated
        if (isValid(generated, $2)) count++
    }
    printf "%4d | %2d %2d %2d | %d\n", NR, ca, cb, cc,  cache_dgroups_hit
    delete rawrecord; delete unkpos; delete cache_dgroups
}
END { print "count = "count}
function isValid(    springs, dgroups, _tmp, i, s, ogsprings, cache_springs) {
    ogsprings = springs
    gsub(/[\\.]+/,".",springs) # squashes repeated dots

    for (i = 1; i <= split(springs, _tmp, SPR_WORKING); i++)
        if (_tmp[i] != "")
            cache_springs[ogsprings][++s] = length(_tmp[i])

    if (dgroups in cache_dgroups) cache_dgroups_hit++
    else for (i = 1; i <= split(dgroups, _tmp, ","); i++)
             cache_dgroups[dgroups][i] = _tmp[i]

    if (length(cache_springs[ogsprings]) != length(cache_dgroups[dgroups]))
        return 0

    for (i in cache_springs[ogsprings])
        if (cache_springs[ogsprings][i] != cache_dgroups[dgroups][i])
            return 0
    return 1
}
