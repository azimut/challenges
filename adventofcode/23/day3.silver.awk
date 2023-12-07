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
                done = 0; part = parts[++p]
                for (digit = 1; digit <= ndigits(part); digit++) { # each digit
                    if (done) { col += 1; continue; }
                    for (y = -1; y <= 1; y++) { # search around digit
                        for (x = -1; x <= 1; x++) {
                            if (schematic[row+y][col+x] !~ /[0-9.]/ && schematic[row+y][col+x] != "") {
                                done = x = y = 42 # break
                                sum += part
                            }
                        }
                    }
                    col += 1
                }
            }
        }
    }
    print sum
}
function ndigits(n) { return int(log(n)/log(10)+1); }
