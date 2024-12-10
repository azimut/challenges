BEGIN { FS=""; OBSTACLE="#"; GUARD="[\\^>v<]"; EMPTY="." }
{
    for (i = 1; i <= NF; i++) {
        if (match($i,GUARD)) {
            guardx = i
            guardy = NR
        }
        patrol_path[i+NF*(NR-1)] = $i
    }
}
END {
    while (is_inside_map(guardx, guardy)) {
        visits[guardx guardy] = 1

        here = coord(guardx,guardy)
        current = patrol_path[here]

        if ("^" == current) { nextx = guardx    ; nexty = guardy - 1}
        if (">" == current) { nextx = guardx + 1; nexty = guardy}
        if ("v" == current) { nextx = guardx    ; nexty = guardy + 1}
        if ("<" == current) { nextx = guardx - 1; nexty = guardy}

        if (map_at(nextx,nexty) == OBSTACLE) {
            if ("^" == current) patrol_path[here] = ">"
            if (">" == current) patrol_path[here] = "v"
            if ("v" == current) patrol_path[here] = "<"
            if ("<" == current) patrol_path[here] = "^"
        } else {
            patrol_path[coord(nextx,nexty)] = current
            patrol_path[here] = "." # erase myself
            guardx = nextx
            guardy = nexty
        }

        print length(visits), ++x, guardx, guardy, map_at(guardx,guardy)
    }
    print length(visits)
}
function coord(x,y) { return x+(y-1)*NR }
function map_at(x,y) { return patrol_path[coord(x,y)] }
function is_inside_map(    x,y) {
    return x > 0 && y > 0 && x <= NF && y <= NR
}
