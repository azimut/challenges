# 105008 i guess
# (1e9-124) % 26 = 18
# 124 the start of the cycle (1 indexed)
# 26 the length of the cycle (1 indexed)
# 18? 19 index of the cycle? starting from zero
BEGIN { FS = ""; FLOOR_BALL = "O"; FLOOR_CUBE = "#"; FLOOR_GROUND = "." }
{
    for (i = 1; i <= NF; i++)
        platform[i][NR] = $i
}
# spin = north west south east
# 1_000_000_000
END {
    printf format_matrix() > "tmp_000_000_000.txt"
    while (spins++ < 1000) {
        # if ((spins % 1000000) == 0)
        #     print spins
        print platform_spin(), spins#, spins-124, spins % 124 # 26
    }
    print "\n", platform_load()
}
function platform_spin() {
    # printf format_matrix(platform) > sprintf("tmp_%010d.txt", spins)
    platform_tilt("north")
    platform_tilt("west")
    platform_tilt("south")
    return platform_tilt("east")
}
function platform_tilt_memo(    direction, stringy) {
    stringy = format_matrix()
    if ((stringy in cache) && (direction in cache[stringy])) {
        print "cache hit!"
        return cache[stringy][direction]
    }
    cache[stringy][direction] = platform_tilt(direction)
    return cache[stringy][direction]
}
function platform_tilt(    direction) { # tilts global "platfrm" and returns north load
    switch (direction) {
    case "north" :
        for (cid in platform)
            for (rid in platform[cid]) {
                offset = 1
                while (platform_at(cid, rid-offset+1) == FLOOR_BALL && platform_at(cid, rid-offset) == FLOOR_GROUND) {
                    platform[cid][rid-offset+1] = FLOOR_GROUND # this one
                    platform[cid][rid-offset]   = FLOOR_BALL   # previous/above
                    offset++
                }
            }
        break
    case "south" :
        for (cid in platform)
            for (rid = length(platform[cid]); rid > 0; rid--) {
                offset = 1
                while (platform_at(cid, rid+offset-1) == FLOOR_BALL && platform_at(cid, rid+offset) == FLOOR_GROUND) {
                    platform[cid][rid+offset-1] = FLOOR_GROUND # this one
                    platform[cid][rid+offset]   = FLOOR_BALL   # previous/above
                    offset++
                }
            }
        break
    case "east" :
        for (rid in platform[1]) {
            for (cid = length(platform[rid]); cid > 0; cid--) {
                offset = 1
                while (platform_at(cid+offset-1, rid) == FLOOR_BALL && platform_at(cid+offset, rid) == FLOOR_GROUND) {
                    platform[cid+offset-1][rid] = FLOOR_GROUND # this
                    platform[cid+offset][rid]   = FLOOR_BALL   # previous/above
                    offset++
                }
            }
        }
        break
    case "west" :
        for (rid in platform[1]) { # assumes regular shape / all rows of same length
            for (cid in platform) {
                offset = 1
                while (platform_at(cid-offset+1, rid) == FLOOR_BALL && platform_at(cid-offset, rid) == FLOOR_GROUND) {
                    platform[cid-offset+1][rid] = FLOOR_GROUND # this
                    platform[cid-offset][rid]   = FLOOR_BALL   # previous/above
                    offset++
                }
            }
        }
        break
    }
    # printf format_matrix(platform) > sprintf("tmp_%010d_%03d_%03d_%s.txt", spins, cid, offset, direction)
    return platform_load()
}
function platform_at(    x, y) {
    return (x in platform && y in platform[x]) ? platform[x][y] : "?"
}
function platform_load(    cid, rid, sum) {
    for (cid in platform)
        for (rid in platform[cid])
            if (platform_at(cid,rid) == FLOOR_BALL)
                sum += length(platform)-rid+1
    return sum
}
function format_matrix(    row, col, res) {
    for (row in platform) {
        for (col in platform[row]) {
            if (col == 1) res = res " "
            if (platform[col][row] == FLOOR_BALL)
                res = res "o"
            else if (platform[col][row] == FLOOR_GROUND)
                res = res " "
            else if (platform[col][row] == FLOOR_CUBE)
                res = res "#"
            else
                res = res platform[col][row]
        }
        res = res sprintf(" \n")
    }
    return res
}
