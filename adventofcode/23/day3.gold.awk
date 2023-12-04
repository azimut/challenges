{
    for (col = 1; col <= split($0, cols, ""); col++)
        schematic[NR][col] = cols[col]
    gsub(/[^0-9]/, " ")
    for (i = 1; i <= split($0, arr); i++)
        parts[++nparts] = arr[i]
}
END {
    for (row in schematic) {
        ncols = length(schematic[row])
        for (col = 1; col <= ncols; col++) {
            if (schematic[row][col] ~ /[0-9]/) { # start of a number
                part = parts[++p]
                for (digit = 1; digit <= ndigits(part); digit++) { # each digit
                    for (y = -1; y <= 1; y++) { # search around digit
                        for (x = -1; x <= 1; x++) {
                            if (schematic[row+y][col+x] == "*" && g2p[row+y][col+x][part] == 0) {
                                g2p[row+y][col+x][part] = 1 # proof relationship
                            }
                        }
                    }
                    col += 1
                }
            }
        }
    }
    for (row in g2p)
        for (col in g2p[row])
            if (length(g2p[row][col]) == 2) { # valid gear
                ratio = 1
                for (part in g2p[row][col])
                    ratio *= part
                sum += ratio
            }
    print sum
}
function ndigits(n) { return int(log(n)/log(10)+1); }
