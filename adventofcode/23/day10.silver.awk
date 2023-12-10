# https://www.w3.org/TR/xml-entity-names/025.html # 0255
BEGIN {
    FS = "";
    PIPE_XX = "."
    PIPE_NS = "║"; PIPE_WE = "═"; PIPE_SW = "╗";
    PIPE_NE = "╚"; PIPE_NW = "╝"; PIPE_SE = "╔";
}
{
    for (i = 1; i <= NF; i++) {
        switch ($i) {
        case "|" : pipe = PIPE_NS; break;
        case "-" : pipe = PIPE_WE; break;
        case "L" : pipe = PIPE_NE; break;
        case "J" : pipe = PIPE_NW; break;
        case "7" : pipe = PIPE_SW; break;
        case "F" : pipe = PIPE_SE; break;
        case "S" : startx = i; starty = NR;
        default  : pipe = $i; break;
        }
        pipes[NR][i] = pipe
    }
}
END {
    print position_probes()
    print "Start = "startx, starty
    print "1 - "pipe_at(probes[1]["curr"]["x"], probes[1]["curr"]["y"]), probes[1]["curr"]["x"], probes[1]["curr"]["y"]
    print "2 - "pipe_at(probes[2]["curr"]["x"], probes[2]["curr"]["y"]), probes[2]["curr"]["x"], probes[2]["curr"]["y"]
    print_laberinth()
    distance = 1
    while(!done) {
        distance++
        for (pid in probes) {
            cx = probes[pid]["curr"]["x"]
            cy = probes[pid]["curr"]["y"]
            px = probes[pid]["prev"]["x"]
            py = probes[pid]["prev"]["y"]
            # print "["pid"]", cx,cy,px,py
            if (pipe_at(cx,cy) == PIPE_NS)
                probes[pid]["curr"]["y"] = (cy > py) ? cy+1 : cy-1
            else if (pipe_at(cx,cy) == PIPE_WE)
                probes[pid]["curr"]["x"] = (cx > px) ? cx+1 : cx-1
            else if (pipe_at(cx,cy) == PIPE_NE) {
                probes[pid]["curr"]["x"] = (cy > py) ? cx+1 : cx
                probes[pid]["curr"]["y"] = (cx < px) ? cy-1 : cy
            }
            else if (pipe_at(cx,cy) == PIPE_NW) {
                probes[pid]["curr"]["x"] = (cy > py) ? cx-1 : cx
                probes[pid]["curr"]["y"] = (cx > px) ? cy-1 : cy
            }
            else if (pipe_at(cx,cy) == PIPE_SW) {
                probes[pid]["curr"]["x"] = (cy < py) ? cx-1 : cx
                probes[pid]["curr"]["y"] = (cx > px) ? cy+1 : cy
            }
            else if (pipe_at(cx,cy) == PIPE_SE) {
                probes[pid]["curr"]["x"] = (cy < py) ? cx+1 : cx
                probes[pid]["curr"]["y"] = (cx < px) ? cy+1 : cy
            }
            else if (pipe-at(cx,cy) == "S") {
                print "START again..."
                done = 1
                break
            }
            else if (pipe_at(cx,cy) == "?")
                print "not found", cx, cy
            else {
                print "???????????", pipe_at(cx,cy), cx, cy
                done = 1
                break
            }

            if (cx == px && cy == py) {
                print "same previous...."
                done = 1
                break
            }
            probes[pid]["prev"]["x"] = cx
            probes[pid]["prev"]["y"] = cy
        }
        if (probesOverlap())
            done = 1
    }
    print "distance="distance
}
function pipe_at(    x, y) {
    if (y in pipes && x in pipes[y])
        return pipes[y][x]
    else
        return "?"
}
function probesOverlap() { # assumes 2 probes
    # print pipe_at(probes[1]["curr"]["x"], probes[1]["curr"]["y"]), probes[1]["curr"]["x"], probes[1]["curr"]["y"]
    # print pipe_at(probes[2]["curr"]["x"], probes[2]["curr"]["y"]), probes[2]["curr"]["x"], probes[2]["curr"]["y"]
    # print ""
    return probes[1]["curr"]["x"] == probes[2]["curr"]["x"] &&
        probes[1]["curr"]["y"] == probes[2]["curr"]["y"]
}
function position_probes(    nprobes, pid) {
    right = pipe_at(startx+1,starty)
    print "R = "right
    if (right == PIPE_WE || right == PIPE_SW || right == PIPE_NW) {
        nprobes++
        probes[nprobes]["curr"]["x"] = startx+1
        probes[nprobes]["curr"]["y"] = starty
    }
    left = pipe_at(startx-1,starty)
    print "L = "left
    if (left == PIPE_WE || left == PIPE_SE || left == PIPE_NE) {
        nprobes++
        probes[nprobes]["curr"]["x"] = startx-1
        probes[nprobes]["curr"]["y"] = starty
    }
    up = pipe_at(startx,starty-1)
    print "U = "up
    if (up  == PIPE_NS || up  == PIPE_SW || up  == PIPE_SE) {
        nprobes++
        probes[nprobes]["curr"]["x"] = startx
        probes[nprobes]["curr"]["y"] = starty-1
    }
    down = pipe_at(startx,starty+1)
    print "D = "down
    if (down == PIPE_NS || down == PIPE_NW || down == PIPE_NE) {
        nprobes++
        probes[nprobes]["curr"]["x"] = startx
        probes[nprobes]["curr"]["y"] = starty+1
    }
    for (pid in probes) {
        probes[pid]["prev"]["x"] = startx
        probes[pid]["prev"]["y"] = starty
    }
    return nprobes
}
function print_laberinth() {
    for (idx in pipes) {
        for (i = 1; i <= length(pipes[idx]); i++)
            printf "%s", pipes[idx][i]
        print ""
    }
}
