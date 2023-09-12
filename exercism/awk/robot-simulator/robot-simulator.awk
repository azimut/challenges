BEGIN {
    switch (dir) {
    case /north|south|east|west/: break
    case "": dir = "north"; break
    default: print "invalid direction"; exit 2
    }
}

/R|L/ { dir = turn_to($0); next }
/A/   { advance()        ; next }
      { print "invalid instruction"; exit 2 }

ENDFILE { print x+0, y+0, dir }

function advance() {
    switch (dir) {
    case "north": y++; break;
    case "south": y--; break;
    case "east":  x++; break;
    case "west":  x--; break;
    }
}

function turn_to(    turn) {
    switch (dir) {
    case "north": return turn == "R" ? "east"  : "west"
    case "south": return turn == "R" ? "west"  : "east"
    case "east":  return turn == "R" ? "south" : "north"
    case "west":  return turn == "R" ? "north" : "south"
    }
}
