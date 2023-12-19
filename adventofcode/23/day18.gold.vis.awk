BEGIN { FS = "[\\(\\)# ]"; encoded=5; x = y = 0; div = div ? div : 10000 }
{
    direction = encoded2direction($encoded)
    dist = int(strtonum("0x"substr($encoded, 1, 5)) / int(div))

    switch (direction) {
    case "R" : to=(x+dist); for(;x<=to; x++) map[x][y]++ ; break
    case "L" : to=(x-dist); for(;x>=to; x--) map[x][y]++ ; break
    case "U" : to=(y-dist); for(;y>=to; y--) map[x][y]++ ; break
    case "D" : to=(y+dist); for(;y<=to; y++) map[x][y]++ ; break
    }

    minx = min(minx, x); maxx = max(maxx, x)
    miny = min(miny, y); maxy = max(maxy, y)

    # print $encoded, substr($encoded, 6, 1), substr($encoded, 1, 5), strtonum("0x"substr($encoded, 1, 5)),
    #     "direction="direction, "dist="dist
}
function encoded2direction(    encoded) {
    switch (substr(encoded, 6, 1)) {
    case "0" : return "R"
    case "1" : return "D"
    case "2" : return "L"
    case "3" : return "U"
    }
}
END {
    width  = maxx - minx
    height = maxy - miny
    format = "P1"
    printf("%s %d %d ", format, width, height)
    for (y = miny; y < maxy; y++) {
        for (x = minx; x < maxx; x++)
            if (x in map && y in map[x])
                printf(" 0")
            else
                printf(" 1")
        print ""
    }
    #print width, height; print minx, maxx; print miny, maxy
}
function max(    x,y) { return (x>y)?x:y  }
function min(    x,y) { return (x<y)?x:y  }
