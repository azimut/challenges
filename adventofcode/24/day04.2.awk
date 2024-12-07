BEGIN { FS = "" }

{
    for (i = 0; i < NF; i++)
        soup[(NF * (NR - 1)) + i + 1] = soup[(NF * (NR - 1)) + i + 1] $(i + 1)
}

END {
    for (cid = 2; cid < NF; cid++) {
        for (rid = 2; rid < NR; rid++) {
            if (lookup(cid,rid) != "A") continue
            diag1 = lookup(cid-1,rid-1) lookup(cid,rid) lookup(cid+1,rid+1) # \
            diag2 = lookup(cid-1,rid+1) lookup(cid,rid) lookup(cid+1,rid-1) # /
            if (is_xmas(diag1) && is_xmas(diag2))
                total++
        }
    }
    print total # 9
}

function lookup(x,y) { return soup[x+NR*(y-1)] }
function is_xmas(s) { return s == "MAS" || s == "SAM" }
