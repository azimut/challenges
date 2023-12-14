# each pattern has a SMUDGE?
BEGIN   { FS = ""; pid = 1; ASH = "."; ROCKS = "#" }
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
            max_mirror(cols[p], colarr); maxcols = colarr["max"]
            max_mirror(rows[p], rowarr); maxrows = rowarr["max"]
            printf "[%3d] C(%2d,%2d) R(%2d,%2d)\n", p,
                maxcols, colarr["count"],
                maxrows, rowarr["count"]
            if (maxcols == 0 && maxrows == 0) print "no mirrows!!"
            else if (maxcols == maxrows)      print "impossible equal!!"
            else if (maxcols < maxrows)       sum += rowarr["count"] * 100
            else                              sum += colarr["count"]
        }
        delete colarr; delete rowarr;
        print "sum="sum
    }
    function equal(xs, ys) { # assumes same index names
        if (length(ys) != length(xs)) return 0
        for (i in xs)
            if ((i in xs) && (i in ys) && (xs[i] != ys[i]))
                return 0
        return 1
    }
    function max(    x,y) { return (x>y)?x:y  }
    function max_mirror(arr,_retarr,    max_amplitude, idx, size, lcursor, rcursor, left, right) {
        size = length(arr)
        max_amplitude = 0
        for (idx = 1; idx < size; idx++) { # check 2 values per iteration
            amplitude = 0
            count     = idx
            lcursor   = idx
            rcursor   = idx + 1
            while ((lcursor > 0) && (rcursor <= size) && (equal(arr[lcursor],arr[rcursor]))) { # check around
                --lcursor
                ++rcursor
                amplitude += 2
            }
            if (amplitude > max_amplitude && (lcursor == 0 || rcursor > size)) { # is a real mirror
                max_amplitude    = amplitude
                _retarr["count"] = count
            }
        }
        _retarr["max"] = max_amplitude
    }
