# INCOMPLETE
# https://www.w3.org/TR/xml-entity-names/025.html # 0255
BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) { # ascii->UTF8
        switch ($i) {
        case "|" : pipe = PIPE_NS = "║"; break;
        case "-" : pipe = PIPE_WE = "═"; break;
        case "L" : pipe = PIPE_NE = "╚"; break;
        case "J" : pipe = PIPE_NW = "╝"; break;
        case "7" : pipe = PIPE_SW = "╗"; break;
        case "F" : pipe = PIPE_SE = "╔"; break;
        case "S" : startx = i; starty = NR;
        default  : pipe = $i; break;
        }
        pipes[NR][i] = pipe
        winding[NR][i] = " "
    }
}
END {
    print position_probe()
    print "Start = "startx, starty
    distance = 1
    while(1) {
        # getline tmp < "-"
        # printf "\033[H"
        # print_laberinth_around_start(15)
        # printf "\033[J"
        distance++
        cx = probe["curr"]["x"]
        cy = probe["curr"]["y"]
        px = probe["prev"]["x"]
        py = probe["prev"]["y"]
        walls[px][py]++

        if      (py > cy)      winding[cy][cx] = "U"
        else if (py < cy)      winding[cy][cx] = "D"
        else winding[cy][cx] = winding[py][px]

        if (pipe_at(cx,cy) == PIPE_NS)
            probe["curr"]["y"] = (cy > py) ? cy+1 : cy-1
        else if (pipe_at(cx,cy) == PIPE_WE)
            probe["curr"]["x"] = (cx > px) ? cx+1 : cx-1
        else if (pipe_at(cx,cy) == PIPE_NE) {
            probe["curr"]["x"] = (cy > py) ? cx+1 : cx
            probe["curr"]["y"] = (cx < px) ? cy-1 : cy
        }
        else if (pipe_at(cx,cy) == PIPE_NW) {
            probe["curr"]["x"] = (cy > py) ? cx-1 : cx
            probe["curr"]["y"] = (cx > px) ? cy-1 : cy
        }
        else if (pipe_at(cx,cy) == PIPE_SW) {
            probe["curr"]["x"] = (cy < py) ? cx-1 : cx
            probe["curr"]["y"] = (cx > px) ? cy+1 : cy
        }
        else if (pipe_at(cx,cy) == PIPE_SE) {
            probe["curr"]["x"] = (cy < py) ? cx+1 : cx
            probe["curr"]["y"] = (cx < px) ? cy+1 : cy
        }
        else if (pipe_at(cx,cy) == "S") {
            print "START again..."
            break
        }
        else if (pipe_at(cx,cy) == "?")
            print "not found", cx, cy
        else {
            print "???????????", pipe_at(cx,cy), cx, cy
            break
        }
        if (cx == px && cy == py) {
            print "same previous...."
            break
        }


        probe["prev"]["x"] = cx
        probe["prev"]["y"] = cy
    }
    # print_laberinth()
    print print_laberinth_around_start(100) #> "day10vis.gold.txt"
    for (y in pipes) {
        for (x in pipes[y]) {
            if (inside_laberinth(x,y)) {
                print "inside:"x,y
                count++
            }
        }
    }
    for (x in winding) {
        for (y in winding[x]) {
            printf winding[x][y]
        }
        print ""
    }
    print "length walls..."length(walls)
    print "inside..."count
    print "distance="int(distance/2)
}
function inside_laberinth(    x, y, xlen, inside) {
    if (is_laberinth(x,y)) return 0 # !!
    inside = 0
    for (i = x; i <= length(pipes[1]); i++) {
        if (is_laberinth(i,y)) {
            inside = (winding_at(i,y) == "U") ? 0 : 1
            break
        }
    }
    return inside
}
function is_laberinth(x, y) { return ((x in walls) && (y in walls[x])) }
function pipe_at(    x, y) {
    return (y in pipes && x in pipes[y]) ? pipes[y][x] : "?"
}
function winding_at(    x, y) {
    return (y in winding && x in winding[y]) ? winding[y][x] : "?"
}
function position_probe(    x, y, right, down, left, up) {
    right = pipe_at(startx+1, starty)
    down  = pipe_at(startx  , starty+1)
    left  = pipe_at(startx-1, starty)
    up    = pipe_at(startx  , starty-1)
    print "R = "right, "L = "left, "U = "up, "D = "down
    if (right == PIPE_WE || right == PIPE_SW || right == PIPE_NW) {
        probe["curr"]["x"] = startx+1
        probe["curr"]["y"] = starty
    }
    else if (left == PIPE_WE || left == PIPE_SE || left == PIPE_NE) {
        probe["curr"]["x"] = startx-1
        probe["curr"]["y"] = starty
    }
    else if (up  == PIPE_NS || up  == PIPE_SW || up  == PIPE_SE) {
        probe["curr"]["x"] = startx
        probe["curr"]["y"] = starty-1
    }
    else if (down == PIPE_NS || down == PIPE_NW || down == PIPE_NE) {
        probe["curr"]["x"] = startx
        probe["curr"]["y"] = starty+1
    }
    x = probe["curr"]["x"]
    y = probe["curr"]["y"]
    printf "(%d,%d) %s\n", x, y, pipe_at(x,y)
    probe["prev"]["x"] = startx
    probe["prev"]["y"] = starty
}
function print_laberinth() {
    for (idx in pipes) {
        for (i = 1; i <= length(pipes[idx]); i++)
            printf "%s", pipes[idx][i]
        print ""
    }
}
function max(    x,y) { return (x>y)?x:y  }
function min(    x,y) { return (x<y)?x:y  }
function print_laberinth_around_start(    range, pid, i, res) {
    for (pid = max(1,starty-range); pid <= min(starty+range,length(pipes)); pid++) {
        for (i = 1; i <= length(pipes[pid]); i++) {
            # print i,pid, is_laberinth(i,pid),is_laberinth(pid,i)
            if (probe["curr"]["x"] == i && probe["curr"]["y"] == pid)
                #printf "\033[0;31m⚹\033[0m"
                res = res sprintf("ß")
            else if (is_laberinth(i,pid))
                res = res pipes[pid][i]
            else if (is_pipe(pipe_at(i,pid)) && !(is_laberinth(i,pid)))
                res = res sprintf(" ")
            # res = res sprintf("W")
            else
                res = res sprintf("%s", pipes[pid][i])
        }
        res = res sprintf("\n")
    }
    return res
}
function is_pipe(    s) {
    return (s == PIPE_NS || s == PIPE_WE || s == PIPE_NW || s == PIPE_NE || s == PIPE_SW || s == PIPE_SE)
}
