BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++) {
        tiles[i][NR]     = $i
        energyMap[i][NR] = "."
        travelMap[i][NR] = "."
    }
}
END {
    for (x = 1; x <= length(tiles); x++) {
        for (y = 1; y <= length(tiles[x]); y++) {
            if (!isBorder(x,y)) continue
            if (x == 1                    && y == 1) { # TL corner
                max_energy = max(max_energy, shoot_and_chase(x,y,"R"))
                max_energy = max(max_energy, shoot_and_chase(x,y,"D"))
            } else if (x == length(tiles) && y == 1) { # TR corner
                max_energy = max(max_energy, shoot_and_chase(x,y,"L"))
                max_energy = max(max_energy, shoot_and_chase(x,y,"D"))
            } else if (x == 1             && y == length(tiles[1])) { # BL corner
                max_energy = max(max_energy, shoot_and_chase(x,y,"U"))
                max_energy = max(max_energy, shoot_and_chase(x,y,"R"))
            } else if (x == length(tiles) && y == length(tiles[1])) {
                max_energy = max(max_energy, shoot_and_chase(x,y,"U"))
                max_energy = max(max_energy, shoot_and_chase(x,y,"L"))
            }
            else if (x == 1)                # | left
                max_energy = max(max_energy, shoot_and_chase(x,y,"R"))
            else if (y == 1)                # - top
                max_energy = max(max_energy, shoot_and_chase(x,y,"D"))
            else if (x == length(tiles))    # | right
                max_energy = max(max_energy, shoot_and_chase(x,y,"L"))
            else if (y == length(tiles[1])) # - bottom
                max_energy = max(max_energy, shoot_and_chase(x,y,"U"))

            # max_energy = max(max_energy, energy)
            printf "x=%3d y=%3d\n", x,y
        }
    }
    print "max_energy="max_energy
}
function max(    x,y) { return (x>y)?x:y  }
function isBorder(    x, y) {
    return (x == 1 || y == 1 || x == length(tiles) || y == length(tiles[1]))
}
function shoot_and_chase(    fromx, fromy, fromdir, energy) {
    shoot(fromx, fromy, fromdir)
    delete counter # !!
    energy = current_energy()
    delete energyMap
    return energy
}
function shoot(    fromx, fromy, fromdir, xoffset, yoffset, newx, newy) {
    # print fromx, fromy, fromdir, tileAt(fromx,fromy)
    if (counter[fromx][fromy][fromdir]++ > 10) { # FIXME: shitty cycle detection
        # print "exit loop"
        return
    }
    if (tileAt(fromx,fromy) != "?")
        energyMap[fromx][fromy] = "#"
    # travelMap[fromx][fromy] = direction2arrow(fromdir)
    # print formatEnergyMap()
    # print formatTravelMap()
    switch (tileAt(fromx,fromy) fromdir) { # concat tile and direction
    case /[\.-]L/  : shoot(fromx-1 , fromy   , fromdir); break # empty or point splitter -
    case /[\.-]R/  : shoot(fromx+1 , fromy   , fromdir); break # empty or point splitter -
    case /[\.\|]U/ : shoot(fromx   , fromy-1 , fromdir); break # empty or point splitter |
    case /[\.\|]D/ : shoot(fromx   , fromy+1 , fromdir); break # empty or point splitter |
    case /-[UD]/   : shoot(fromx-1 , fromy   , "L"); shoot(fromx+1, fromy   , "R"); break # spliter -
    case /\|[LR]/  : shoot(fromx   , fromy-1 , "U"); shoot(fromx  , fromy+1 , "D"); break # spliter |
    case /\/L/     : shoot(fromx   , fromy+1 , "D"); break # mirror /
    case /\/R/     : shoot(fromx   , fromy-1 , "U"); break
    case /\/U/     : shoot(fromx+1 , fromy   , "R"); break
    case /\/D/     : shoot(fromx-1 , fromy   , "L"); break
    case /\\L/     : shoot(fromx   , fromy-1 , "U"); break # mirror \
    case /\\R/     : shoot(fromx   , fromy+1 , "D"); break
    case /\\U/     : shoot(fromx-1 , fromy   , "L"); break
    case /\\D/     : shoot(fromx+1 , fromy   , "R"); break
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
