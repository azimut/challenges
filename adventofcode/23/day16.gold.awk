BEGIN { FS = ""; FILE_EMPTY = "."; MY_EMPTY = " " }
{
    for (i = 1; i <= NF; i++) {
        tiles[i][NR]     = $i
        energyMap[i][NR] = MY_EMPTY
        travelMap[i][NR] = $i
    }
}
END {
    # for (x = 1; x <= length(tiles); x++)
    #     for (y = 1; y <= length(tiles[x]); y++) {
    #         if (x == 1 && y == 1) {                    # TL corner
    #             register_energy(shoot_and_chase(x,y,"R"),x,y,"R")
    #             register_energy(shoot_and_chase(x,y,"D"),x,y,"D")
    #         } else if (x == length(tiles) && y == 1) { # TR corner
    #             register_energy(shoot_and_chase(x,y,"L"),x,y,"L")
    #             register_energy(shoot_and_chase(x,y,"D"),x,y,"D")
    #         } else if (x == 1 && y == length(tiles[1])) { # BL corner
    #             register_energy(shoot_and_chase(x,y,"U"),x,y,"U")
    #             register_energy(shoot_and_chase(x,y,"R"),x,y,"R")
    #         } else if (x == length(tiles) && y == length(tiles[1])) {
    #             register_energy(shoot_and_chase(x,y,"U"),x,y,"U")
    #             register_energy(shoot_and_chase(x,y,"L"),x,y,"L")
    #         }
    #         else if (x == 1)                # | left
    #             register_energy(shoot_and_chase(x,y,"R"),x,y,"R")
    #         else if (y == 1)                # - top
    #             register_energy(shoot_and_chase(x,y,"D"),x,y,"D")
    #         else if (x == length(tiles))    # | right
    #             register_energy(shoot_and_chase(x,y,"L"),x,y,"L")
    #         else if (y == length(tiles[1])) # - bottom
    #             register_energy(shoot_and_chase(x,y,"U"),x,y,"U")
    #     }
    max_energy = max(max_energy, shoot_and_chase(1,89,"R"))
    print "max_energy="max_energy
    for (x in energies[max_energy]) {
        for (y in energies[max_energy][x]) {
            print x,y
        }
    }
}
function register_energy(    energy, x, y, direction) {
    energies[energy][x][y]++
    max_energy = max(max_energy, shoot_and_chase(x,y,direction))
}
function max(    x,y) { return (x>y)?x:y  }
function shoot_and_chase(    fromx, fromy, fromdir, energy) {
    shoot(fromx, fromy, fromdir)
    delete counter # !!
    energy = current_energy()
    delete energyMap
    return energy
}
function shoot(    fromx, fromy, fromdir, xoffset, yoffset, newx, newy) {
    # print fromx, fromy, fromdir, tileAt(fromx,fromy)
    if (counter[fromx][fromy][fromdir]++ > 0) return # cycle detection
    if (tileAt(fromx,fromy) != "?")
        energyMap[fromx][fromy] = "#"
    if (tileAt(fromx,fromy) == FILE_EMPTY)
        travelMap[fromx][fromy] = direction2arrow(fromdir)
    # print formatEnergyMap()
    if (flaggie++ % 5 == 0)
        print formatTravelMap() > sprintf("tmp_day16_%06d.txt", s++)
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

function tileAt(    x,y) { return (x in tiles && y in tiles[x]) ? tiles[x][y] : "?" }
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
            if (travelMap[cid][rid] == FILE_EMPTY)
                res = res MY_EMPTY
            else
                res = res travelMap[cid][rid]
        res = res "\n"
    }
    return res
}
function direction2arrow(    direction) {
    switch (direction) {
    case "R": return "→" #">"
    case "L": return "←" #"<"
    case "U": return "↑" #"^"
    case "D": return "↓" #"v"
    }
}
