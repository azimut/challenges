#
# ABANDONED!!!!!
#
# given arrays are always passed by reference, keep track of the visited
# places is too annyoing, either
# - I explode/split and implode/join a string of a list of pairs, each iteration (yikes)
# - or a create a datastructure that recreates the function stack's backtracking (pain)
#
BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) {
        map[i][NR] = $i
        view[NR][i] = " "
    }
}
END {
    walk(1,1,"R", 0, 0)
    walk(1,1,"D", 0, 0)
    print "min_heat_loss", min_heat_loss()
}
function walk(    x, y, orientation, acc, counter, travel, c, view,
                  loss) {

    loss = map_at(x,y)
    if (loss == "?")      return # exit if outside map

    if ((x,y) in travel) { # cycle detection
        return
    }
    travel = travel ";" x "," y
    travel[x,y]++

    view[y][x] = orientation2arrow(orientation)
    printf formatMap(view)
    print c,x,y,counter, orientation, "=", acc "\n"

    if (x != 1 && y != 1) acc += loss

    if (x == length(map) && y == length(map[1])){ # end
        print "end!", acc, loss, x, y
        print formatMap(view)
        # resetMap()
        paths[++ends] = acc
        return
    }
    if (orientation == "U") {
        if (counter < 2) walk(x, y-1, orientation, acc, counter+1, travel, c+1, view)
        walk(x-1 , y , "L", acc, 0, travel, c+1, view)
        walk(x+1 , y , "R", acc, 0, travel, c+1, view)
    }
    if (orientation == "D") {
        if (counter < 2) walk(x, y+1, orientation, acc, counter+1, travel, c+1, view)
        walk(x-1 , y , "L", acc, 0, travel, c+1, view)
        walk(x+1 , y , "R", acc, 0, travel, c+1, view)
    }
    if (orientation == "L") {
        if (counter < 2) walk(x-1, y, orientation, acc, counter+1, travel, c+1, view)
        walk(x , y+1 , "D", acc, 0, travel, c+1, view)
        walk(x , y-1 , "U", acc, 0, travel, c+1, view)
    }
    if (orientation == "R") {
        if (counter < 2) walk(x+1, y, orientation, acc, counter+1, travel, c+1, view)
        walk(x , y+1 , "D", acc, 0, travel, c+1, view)
        walk(x , y-1 , "U", acc, 0, travel, c+1, view)
    }
}
function map_at(    x,y) {
    return (x in map && y in map[x]) ? map[x][y] : "?"
}
function min(    x,y) { return (int(x)<int(y))?x:y  }
function min_heat_loss(    pid, res) {
    res = 1e99
    for (pid in paths) {
        print paths[pid]
        res = min(res, paths[pid])
    }
    return res
}
function orientation2arrow(    orientation) {
    switch (orientation) {
    case "R": return "→" # ">"
    case "L": return "←" # "<"
    case "U": return "↑" # "^"
    case "D": return "↓" # "v"
    default : return "?"
    }
}
function formatMap(    view, s) {
    for (y = 1; y <= length(map[1]); y++) {
        for (x = 1; x <= length(map); x++) {
            if (y in view && x in view[y])
                s = s view[y][x]
            else
                s = s " "
        }
        s = s "\n"
    }
    return s
}
function resetMap(    view) {
    for (y = 1; y <= length(view); y++) {
        for (y = 1; y <= length(view[1]); y++) {
            view[y][x] = " "
        }
    }
}
