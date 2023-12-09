{
    level = 1
    for (i = 1; i <= NF; i++)
        readings[NR][level][i] = $i
}
END {
    for (r in readings) {
        level = 1
        while (1) { # assumes they will reach zero :)
            zeroes = 0
            for (i = 1; i < length(readings[r][level]); i++) {
                left  = readings[r][level][i]
                right = readings[r][level][i+1]
                diff  = right - left
                readings[r][level+1][i] = diff
                if (diff == 0)
                    zeroes++
            }
            if (zeroes == length(readings[r][level+1])) {
                for (rlevel = level; rlevel >= 1; rlevel--) {
                    below = readings[r][rlevel+1][length(readings[r][rlevel+1])]
                    left = readings[r][rlevel][length(readings[r][rlevel])]
                    new = below + left
                    readings[r][rlevel][length(readings[r][rlevel])+1] = new
                }
                prediction = readings[r][1][length(readings[r][1])]
                predictions += prediction
                break
            }
            else
                level++
        }
    }
    print predictions
}
