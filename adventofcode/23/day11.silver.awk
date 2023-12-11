BEGIN { FS = ""; GALAXY = "#"; EMPTY = "."}

{
    for (i = 1; i <= NF; i++)
        image[NR+roffset][i] = $i
}

/^\.+$/ { # adds an extra empty row
    roffset++
    for (i = 1; i <= NF; i++)
        image[NR+roffset][i] = EMPTY
}

END {
    for (col in image[1]) { # add cols into expanded[][]
        nempty = 0
        for (row in image) {
            expanded[row][col+coffset] = image[row][col]
            if (image[row][col] == EMPTY)
                nempty++
        }
        if (nempty == length(image)) { # all row empty
            coffset++
            for (row in image)
                expanded[row][col+coffset] = EMPTY
        }
    }

    for (row in expanded) # find all the galaxies
        for (col in expanded[row])
            if (expanded[row][col] == GALAXY) {
                ngalaxies++
                galaxies[ngalaxies]["x"] = col
                galaxies[ngalaxies]["y"] = row
            }

    for (i = 1; i < length(galaxies); i++)
        for (j = i+1; j <= length(galaxies); j++)
            sum += galaxy_distance(i,j)

    print format_matrix(expanded) > "day11e.txt"
    # print format_matrix(expanded)
    printf "expanded = %dx%d\n", length(expanded[1]), length(expanded)
    print "sum = "sum
}

function galaxy_distance(   i,j,x1,y1,x2,y2,dist) {
    x1 = galaxies[i]["x"]
    y1 = galaxies[i]["y"]
    x2 = galaxies[j]["x"]
    y2 = galaxies[j]["y"]
    dist = abs(x1-x2) + abs(y1-y2)
    printf "%2d = %d(%d,%d) -> %d(%d,%d)\n", dist, i, x1, y1, j, x2, y2
    return dist
}
function abs(    x)   { return (x<0)?-x:x }
function format_matrix(    arr, row, col, res) {
    for (row in arr) {
        for (col in arr[row])
            res = res sprintf(arr[row][col])
        res = res sprintf("\n")
    }
    return res
}
