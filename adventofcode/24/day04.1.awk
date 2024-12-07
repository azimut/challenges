BEGIN { FS = "" }

{
    rows[NR] = $0
    for (i = 0; i < NF; i++) {
        cols[i] = cols[i] $(i+1)
        soup[(NF * (NR-1)) + i + 1] = soup[(NF * (NR-1)) + i + 1] $(i + 1)
    }
}

END {
    for (rid in rows) total += count_xmas(rows[rid])
    for (cid in cols) total += count_xmas(cols[cid])
    # diagonals                                 \
    for (cid = 1; cid <= NF; cid++) { # up
        rid = 0
        diag = ""
        for (coord = cid; coord <= NF; coord++) {
            diag = diag soup[coord + (NR*rid++)]
        }
        total += count_xmas(diag)
        }
    for (rid = 2; rid <= NR; rid++) { # bottom
        cid = 1
        diag = ""
        for (coord = rid; coord <= NR; coord++) {
            idx = cid++ + (NR*(coord-1))
            diag = diag soup[idx]
        }
        total += count_xmas(diag)
    }
    # antidiagonals /
    for (cid = NF; cid > 0; cid--) { # up
        rid = 0
        diag = ""
        for (coord = cid; coord > 0; coord--) {
            diag = diag soup[(coord + NR*rid++)]
        }
        total += count_xmas(diag)
    }
    for (rid = 2; rid <= NR; rid++) { # down
        cid = NF
        diag = ""
        for (coord = rid; coord <= NR; coord++) {
            diag = diag soup[cid-- + (coord-1)*NR]
        }
        total += count_xmas(diag)
    }
    print total # 18 = 5H 3V
}

function count_xmas(s) {
    return gsub("XMAS", "&", s) + gsub("SAMX", "&", s)
}
