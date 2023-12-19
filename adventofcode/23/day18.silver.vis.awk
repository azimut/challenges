BEGIN { FS = "[\\(\\)# ]"; direction=1; distance=2; color=5; x = y = 0; }
{
    rgb = color2rgb($color)
    switch ($direction) {
    case "R" : to=(x+$distance); for(;x<=to; x++) colormap[x][y] = rgb ; break
    case "L" : to=(x-$distance); for(;x>=to; x--) colormap[x][y] = rgb ; break
    case "U" : to=(y-$distance); for(;y>=to; y--) colormap[x][y] = rgb ; break
    case "D" : to=(y+$distance); for(;y<=to; y++) colormap[x][y] = rgb ; break
    }
    minx = min(minx, x); maxx = max(maxx, x)
    miny = min(miny, y); maxy = max(maxy, y)
    print $direction, $distance, $color, rgb
}
END {
    width  = maxx - minx
    height = maxy - miny
    format = "P3"
    maxcolor = 255
    res = sprintf("%s %d %d %d", format, width, height, maxcolor)
    for (y = miny; y < maxy; y++) {
        for (x = minx; x < maxx; x++)
            if (x in colormap && y in colormap[x])
                res = res " " colormap[x][y]
            else
                res = res " 0 0 0"
    }
    print res > "day18.silver.vis.pbm"
    print width, height; print minx, maxx; print miny, maxy
}
function color2rgb(    color) { # 70c710 = 112 199 16
    r = strtonum("0x"substr(color, 0, 2))
    g = strtonum("0x"substr(color, 3, 2))
    b = strtonum("0x"substr(color, 5, 2))
    return sprintf("%d %d %d", r, g, b)
}
function max(    x,y) { return (x>y)?x:y  }
function min(    x,y) { return (x<y)?x:y  }
