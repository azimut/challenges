BEGIN { FS = "" }
{
    for (i = 1; i <= NF; i++)
        diagram[NR][i] = $i
}
END {
    for (x = 1; x <= NR; x++) {
        for (y = 1; y <= NF; y++) {
            if (diagram[x][y] != "@") {
                continue
            }
            papers = 0
            for (dx = -1; dx <= 1; dx++) {
                for (dy = -1; dy <= 1; dy++) {
                    if (dx == 0 && dy == 0)
                        continue
                    if ((x+dx > 0) && (x+dx <= NR) &&
                        (y+dy > 0) && (y+dy <= NF) &&
                        (diagram[x+dx][y+dy] == "@"))
                        papers++
                }
            }
            if (papers < 4)
                movables++
        }
    }
    print movables
}
