BEGIN { categories[++cid] = "seed"; _range=3; _src=2; _dst=1; init() }

/seeds:/ { # add seeds ranges
    for (i = 2; i <= NF; i += 2) push($i, $(i+1)) # push seeds
    swap() }
/map:/   { # add category
    category          = substr($1, 4+index($1,"-to-"))
    categories[++cid] = category
    mid               = 0 }
/^[0-9]/ { # add mappings to category
    mid++
    mapping[category][mid]["range"]       = $_range
    mapping[category][mid]["source"]      = $_src
    mapping[category][mid]["destination"] = $_dst }

END {
    for (cid in categories) { # used to iter the mappings
        if (categories[cid] == "location") { print size(); break; } # no next category
        printf "\n\n+++ %s to %s +++\n", categories[cid], categories[cid+1]
        # if (++zz > 1) break
        for (sid = 1; sid <= size(); sid++) { # iterate over seeds
            from_pos    = lookup_from(sid)
            from_range  = lookup_dist(sid)
            intersected = 0
            for (mid in mapping[categories[cid+1]]) {
                to_pos      = mapping[categories[cid+1]][mid]["source"]
                to_range    = mapping[categories[cid+1]][mid]["range"]
                destination = mapping[categories[cid+1]][mid]["destination"]
                # print "> sid="sid,"mid="mid,"src="to_pos,"rng="to_range
                if (intersects(from_pos, from_range, to_pos, to_range)) {
                    intersected++
                    isrc = intersection_src(from_pos, to_pos, destination)
                    irng = intersection_distance(from_pos, from_range, to_pos, to_range)
                    if (isrc == 0 || from_pos == 0)
                        printf "inter [%3d [%3d] %3d] -> [%3d [%3d] %3d] -> [%3d [%3d] %3d]\n",
                            from_pos , from_range , from_pos + from_range - 1,
                            to_pos   , to_range   , to_pos + to_range - 1,
                            isrc     , irng       , isrc + irng - 1
                    push(isrc, irng)

                    dlsrc = difference_left_src(from_pos, from_range, to_pos, to_range)
                    dlrng = difference_left_distance(from_pos, from_range, to_pos, to_range)
                    # if (dlsrc != -1 && dlrng != -1) printf "L (%3d,%3d)\n", dlsrc, dlrng
                    push(dlsrc, dlrng)

                    drsrc = difference_right_src(from_pos, from_range, to_pos, to_range)
                    drrng = difference_right_distance(from_pos, from_range, to_pos, to_range)
                    # if (drsrc != -1 && drrng != -1) printf "R (%3d,%3d)\n", drsrc, drrng
                    push(drsrc, drrng)
                }
            }
            if (!intersected) {
                if (from_pos == 0)
                    printf "= [%d [%d] %d]\n", from_pos, from_range, from_pos+from_range-1
                push(from_pos, from_range)
            }
        }
        swap()
    }
    minLocation = 1e99 # hopefullly is big enough
    print _rsize, _wsize
    for (i = 1; i <= size(); i++) {
        if (lookup_from(i) > 0) {
            # print "?"lookup_from(i)
        }
        minLocation = min(minLocation, lookup_from(i))
    }
    print "MIN: "minLocation
}
# 123_251_703 TOO HIGH
#  49_693_880 TOO HIGH
#  14_149_303 TOO LOW
function min(    x,y) { return (int(x) < int(y))?x:y  }
function intersects(    xsrc, xdist, ysrc, ydist) {
    if (int(xsrc) <= int(ysrc)) return int(ysrc) <= int(xsrc+xdist) # before/outer
    else                        return int(xsrc) <= int(ysrc+ydist) # after/inner
}
function intersection_src(    xsrc, ysrc, newsrc) {
    if (int(xsrc) <= int(ysrc)) return newsrc               # before, outer
    else                        return newsrc + (xsrc-ysrc) #  after, inside
}
function intersection_distance(    xsrc, xdist, ysrc, ydist) {
    distance = 0
    if (int(xsrc) >= int(ysrc) && int(xsrc+xdist) <= int(ysrc+ydist)) # inside
        distance = xdist
    else if (int(xsrc) < int(ysrc) && int(xsrc+xdist) > int(ysrc+ydist)) # outside
        distance = ydist
    else if (int(xsrc) <= int(ysrc))
        distance = ((xsrc+xdist)-ysrc)
    else
        distance = ((ysrc+ydist)-xsrc)
    return distance? distance : -1
}
function difference_right_src(    xsrc, xdist, ysrc, ydist) {
    #print xsrc, xdist, ysrc, ydist,(xsrc+xdist),(ysrc+ydist),((xsrc+xdist) > (ysrc+ydist))
    return (int(xsrc+xdist) > int(ysrc+ydist-1)) ? ysrc+ydist : -1
}
function difference_right_distance(    xsrc, xdist, ysrc, ydist) {
    return (int(xsrc+xdist) > int(ysrc+ydist)) ? ((xsrc+xdist) - (ysrc+ydist)) : -1
}
function difference_left_src(    xsrc, xdist, ysrc, ydist) {
    return ((int(xsrc) < int(ysrc)) ? xsrc : -1)
}
function difference_left_distance(    xsrc, xdist, ysrc, ydist) {
    return ((int(xsrc) < int(ysrc)) ? ysrc-xsrc : -1)
}
function init() { _read = 0; _write = 1 }
function swap() { # TODO: better name?
    delete _arr[_read] # wipe the old reader
    _rsize = _wsize
    _wsize = 0
    _read  = _read  ? 0 : 1 # swap pointers
    _write = _write ? 0 : 1
}
function size() { return _rsize }
function push(    from, dist) {
    if (from == -1 || dist == -1) return
    _wsize++
    _arr[_write][_wsize]["from"] = from
    _arr[_write][_wsize]["dist"] = dist
}
function lookup_from(    i) { return _arr[_read][i]["from"] }
function lookup_dist(    i) { return _arr[_read][i]["dist"] }
