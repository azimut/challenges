BEGIN { FS = "" }
{
    for (y = 1; y <= NF; y++) {
        if ($y == "S") {
            startx = NR
            starty = y
        }
        diagram[NR][y] = $y
    }
}
function solve(    x, y) {
    if ((x in cache) && (y in cache[x]))
        return cache[x][y]
    if (x > NR)
        cache[x][y] = 1
    if (diagram[x][y] == "." || diagram[x][y] == "S")
        cache[x][y] = solve(x+1, y)
    else if (diagram[x][y] == "^")
        cache[x][y] = solve(x, y - 1) + solve(x, y + 1)
    return cache[x][y]
}
END {
    print solve(startx,starty)
}
