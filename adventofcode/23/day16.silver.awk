BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) {
        tiles[i][NR]     = $i
        energyMap[i][NR] = "."
        travelMap[i][NR] = "."
    }
}
END {
    shoot(1,1,"D") # TODO: need to consider initial row, SO THIS SHOULD BE "R"
    print "energy="current_energy()
}
function shoot(    fromx, fromy, fromdir, xoffset, yoffset, newx, newy) {
    # print fromx, fromy, fromdir, tileAt(fromx,fromy)
    if (counter[fromx][fromy][fromdir]++ > 10) { # FIXME: shitty cycle detection
        print "exit loop"
        return
    }
    energyMap[fromx][fromy] = "#"
    # travelMap[fromx][fromy] = direction2arrow(fromdir)
    #print formatEnergyMap()
    # print formatTravelMap()
    switch (fromdir) {
    case "R" : xoffset = +1; break
    case "L" : xoffset = -1; break
    case "U" : yoffset = -1; break
    case "D" : yoffset = +1; break
    }
    newx = fromx+xoffset; newy = fromy+yoffset
    switch (tileAt(newx,newy) fromdir) { # concat tile and direction
    case /\../    : shoot(newx, newy, fromdir); break;

    case /-[LR]/  : shoot(newx, newy, fromdir); break
    case /-[UD]/  : shoot(newx, newy, "L"); shoot(newx, newy, "R"); break
    case /\|[UD]/ : shoot(newx, newy, fromdir); break
    case /\|[LR]/ : shoot(newx, newy, "U"); shoot(newx, newy, "D"); break

    case /\/L/    : shoot(newx, newy, "D"); break
    case /\/R/    : shoot(newx, newy, "U"); break
    case /\/U/    : shoot(newx, newy, "R"); break
    case /\/D/    : shoot(newx, newy, "L"); break

    case /\\L/    : shoot(newx, newy, "U"); break
    case /\\R/    : shoot(newx, newy, "D"); break
    case /\\U/    : shoot(newx, newy, "L"); break
    case /\\D/    : shoot(newx, newy, "R"); break
    default : break # tile outside range
    }
}
function tileAt(    x,y) {
    return (x in tiles && y in tiles[x]) ? tiles[x][y] : "?"
}
function current_energy(    rid,cid,energy) {
    energy = 0
    for (rid in energyMap)
        for (cid in energyMap[rid])
            if (energyMap[rid][cid] == "#")
                energy++
    return energy
}
function formatEnergyMap(    res) {
    res = ""
    for (rid in energyMap) {
        for (cid in energyMap[rid])
            res = res energyMap[cid][rid]
        res = res "\n"
    }
    return res
}
function formatTravelMap(    res) {
    res = ""
    for (rid in travelMap) {
        for (cid in travelMap[rid])
            if (tileAt(cid,rid) != ".")
                res = res tileAt(cid,rid)
            else
                res = res travelMap[cid][rid]
        res = res "\n"
    }
    return res
}
function direction2arrow(    direction) {
    switch (direction) {
    case "R": return ">"
    case "L": return "<"
    case "U": return "^"
    case "D": return "v"
    }
}
