BEGIN   { FS = ""; pid = 1 }
/^$/    { pid++; idx = 0; next }
        {
            idx++
            for (i = 1; i <= NF; i++) {
                rows[pid][idx][i] = $i
                cols[pid][i][idx] = $i
            }
        }
    END {
        for (p = 1; p <= pid; p++) {
            max_mirror(cols[p], colarr,p,0); maxcols = colarr["max"]
            max_mirror(rows[p], rowarr,p,1); maxrows = rowarr["max"]
            printf "[%3d] C(%2d,%2d) R(%2d,%2d)\n", p,
                maxcols, colarr["count"],
                maxrows, rowarr["count"]
            if (maxcols == 0 && maxrows == 0) print "no mirrows!!"
            else if (maxcols == maxrows)      print "impossible equal!!"
            else if (maxcols < maxrows)       sum += rowarr["count"] * 100
            else                              sum += colarr["count"]
        }
        print "sum="sum
    }
    function diffs(xs, ys,    count) { # assumes same index names
        count = 0
        for (i in xs)
            if ((i in xs) && (i in ys) && (xs[i] != ys[i]))
                count++
        return count
    }
    function max_mirror(arr,_retarr,pid,isRow,    max_amplitude, idx, size, lcursor, rcursor, left, right) {
        size = length(arr)
        max_amplitude = 0
        for (idx = 1; idx < size; idx++) { # check 2 values per iteration
            lcursor     = idx
            rcursor     = idx + 1
            differences = diffs(arr[lcursor],arr[rcursor])
            canHaveDiff = 1 # YES
            count       = idx
            amplitude   = 0
            while ((lcursor > 0) && (rcursor <= size) && (differences == 0 || (canHaveDiff && differences == 1))) {
                # print printPattern(pid,lcursor,rcursor,isRow) > pid "_" isRow "_" idx "_"abs(lcursor-idx) "_" rcursor ".txt"
                differences += diffs(arr[--lcursor],arr[++rcursor])
                amplitude   += 2
                if (canHaveDiff && differences == 1) {
                    differences = 0
                    canHaveDiff = 0
                }
            }
            if (amplitude > max_amplitude && (lcursor == 0 || rcursor > size) && canHaveDiff == 0) {
                # print printPattern(pid,lcursor,rcursor,isRow) > pid "_" isRow "_" idx "_" abs(lcursor-idx) "_"rcursor ".txt"
                max_amplitude    = amplitude
                _retarr["count"] = count
            }
        }
        _retarr["max"] = max_amplitude
    }
    function abs(    x)   { return (x<0)?-x:x }
    function printPattern(pid, cursora, cursorb, isRow) {
        result = ""
        if (isRow) result = result " \n" # add extra lines at top

        for (rid in rows[pid]) {

            if (isRow && ((rid == cursora)||(rid == cursorb))) # ->
                result = result "> "
            else
                result = result "  "

            if (!isRow && rid == 1) {
                for (cid in rows[pid][rid]) {
                    if ((cid == cursora)||(cid == cursorb))
                        result = result "v"
                    else
                        result = result " "
                }
                result = result "\n  "
            }

            for (cid in rows[pid][rid]) {
                result = result rows[pid][rid][cid]
            }
            result = result " \n"
        }
        result = result "\n"
        return result
    }
