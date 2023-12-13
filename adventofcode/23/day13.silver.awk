BEGIN   { FS = ""; pid = 1 }
/^$/    { pid++; row = 0; next }
        {
            rows[pid][++row] = $0
            for (i = 1; i <= NF; i++)
                cols[pid][i] = cols[pid][i] $i
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
        print "sum="sum
    }
    function max(    x,y) { return (x>y)?x:y  }
    function max_mirror(arr,_retarr,    max_amplitude, idx, size, lcursor, rcursor, left, right) {
        size = length(arr)
        max_amplitude = 0
        for (idx = 1; idx < size; idx++) {
            amplitude = 0
            count     = idx
            lcursor   = idx
            rcursor   = idx + 1
            left      = arr[lcursor]
            right     = arr[rcursor]
            while ((lcursor > 0) && (rcursor <= size) && (left == right)) {
                left  = arr[--lcursor]
                right = arr[++rcursor]
                amplitude += 2
            }
            if (amplitude > max_amplitude && (lcursor == 0 || rcursor > size)) {
                max_amplitude    = amplitude
                _retarr["count"] = count
            }
        }
        _retarr["max"] = max_amplitude
    }
