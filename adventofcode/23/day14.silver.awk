BEGIN { FS = ""; FLOOR_BALL = "O"; FLOOR_CUBE = "#"; FLOOR_GROUND = "." }
{
    for (i = 1; i <= NF; i++)
        platform[i][NR] = $i
}
END {
    printf format_matrix(platform) > "tmp_000_000_000.txt"
    for (cid in platform) {
        for (rid in platform[cid]) {
            if (platform_at(cid,rid) != FLOOR_BALL)
                continue
            offset = 1
            while (platform_at(cid, rid-offset+1) == FLOOR_BALL && platform_at(cid, rid-offset) == FLOOR_GROUND) {
                platform[cid][rid-offset+1] = FLOOR_GROUND # here
                platform[cid][rid-offset] = FLOOR_BALL # previous
                offset++
            }
        }
        printf format_matrix(platform) > sprintf("tmp_%03d_%03d.txt", cid, offset)
    }
    for (cid in platform) {
        for (rid in platform[cid]) {
            if (platform_at(cid,rid) == FLOOR_BALL) {
                sum += length(platform)-rid+1
            }
        }
    }
    # printf format_matrix(platform)
    print "sum="sum
}
function platform_at(    x, y) {
    return (x in platform && y in platform[x]) ? platform[x][y] : "?"
}
function format_matrix(    arr, row, col, res) {
    for (row in arr) {
        for (col in arr[row]) {
            if (col == 1) res = res " "
            if (arr[col][row] == FLOOR_BALL)
                res = res "o"
            else if (arr[col][row] == FLOOR_GROUND)
                res = res " "
            else if (arr[col][row] == FLOOR_CUBE)
                res = res "_"
            else
                res = res arr[col][row]
        }
        res = res sprintf(" \n")
    }
    return res
}
