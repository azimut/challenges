BEGIN { FS = ""; EMPTY = "." }
{
    for (cid = 1; cid <= NF; cid++) {
        freq = $cid
        map[cid+((NR-1)*NF)] = freq
        if (freq != EMPTY) {
            antennas[freq][length(antennas[freq])+1] = cid "," NR
        }
    }
}
END {
    for (freq in antennas) {
        for (i = 1; i <= length(antennas[freq]) - 1; i++) {
            split(antennas[freq][i], antenna1, ",")
            for (j = i + 1; j <= length(antennas[freq]); j++) {
                split(antennas[freq][j], antenna2, ",")

                mul = 0
                while (1) {
                    dx = antenna2[1] - (antenna1[1] - antenna2[1]) * mul
                    dy = antenna2[2] - (antenna1[2] - antenna2[2]) * mul
                    if (is_inside_map(dx, dy)) {
                        map[dx + (dy-1) * NF] = "#"
                        antinodes[dx","dy] = 1
                        anti++
                    } else { break }
                    mul++
                }

                mul = 0
                while (1) {
                    dx = antenna2[1] + (antenna1[1] - antenna2[1]) * mul
                    dy = antenna2[2] + (antenna1[2] - antenna2[2]) * mul
                    if (is_inside_map(dx, dy)) {
                        map[dx + (dy-1) * NF] = "#"
                        antinodes[dx","dy] = 1
                        anti++
                    } else { break }
                    mul++
                }

                mul = 0
                while (1) {
                    dx = antenna1[1] - (antenna2[1] - antenna1[1]) * mul
                    dy = antenna1[2] - (antenna2[2] - antenna1[2]) * mul
                    if (is_inside_map(dx, dy)) {
                        map[dx + (dy-1) * NF] = "#"
                        antinodes[dx","dy] = 1
                        anti++
                    } else { break }
                    mul++
                }
                mul = 0
                while (1) {
                    dx = antenna1[1] + (antenna2[1] - antenna1[1]) * mul
                    dy = antenna1[2] + (antenna2[2] - antenna1[2]) * mul
                    if (is_inside_map(dx, dy)) {
                        map[dx + (dy-1) * NF] = "#"
                        antinodes[dx","dy] = 1
                        anti++
                    } else { break }
                    mul++
                }

            }
        }
    }
    print_mat()
    print length(antinodes), anti # 14 34 NO 1259 too low
}
function is_inside_map(    x,y) { return x >= 1 && x <= NF && y >= 1 && y <= NR }
function print_mat(    rid, cid) {
    print ""
    for (rid = 1; rid <= NR; rid++) {
        for (cid = 1; cid <= NF; cid++) {
            printf map[cid + ((rid-1)*NF)]
        }
        printf "\n"
    }
}
