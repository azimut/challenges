# 18
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
    # anti-diagonals
    # for (i = 0; i < length(cols) + length(rows) - 1; i++) {
    #     print i
    # }
    print total
}

function count_xmas(s) { return gsub("XMAS", "&", s) + gsub("SAMX", "&", s) }
