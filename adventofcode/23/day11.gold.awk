BEGIN { FS = ""; GALAXY = "#"; EMPTY = "."}

{
    for (i = 1; i <= NF; i++)
        image[NR+roffset][i] = $i
}

/^\.+$/ { empty_rows[NR] = 1; print "empty_row = "NR }

END {
    for (col in image[1]) {
        nempty = 0
        for (row in image)
            if (image[row][col] == EMPTY)
                nempty++
        if (nempty == length(image)) {
            print "empty_col = "col
            empty_cols[col] = 1
        }
    }

    for (row in image) # find all the galaxies
        for (col in image[row])
            if (image[row][col] == GALAXY) {
                ngalaxies++
                galaxies[ngalaxies]["x"] = col
                galaxies[ngalaxies]["y"] = row
            }

    for (i = 1; i < length(galaxies); i++)
        for (j = i+1; j <= length(galaxies); j++) {
            distance = galaxy_distance(i,j,1000000)
            # printf "%2d = %d(%d,%d)(%d,%d) -> %d(%d,%d)(%d,%d)\n",
            #     distance,
            #     i, galaxies[i]["x"], galaxies[i]["y"], galaxy_posx(i,2), galaxy_posy(i,2),
            #     j, galaxies[j]["x"], galaxies[j]["y"], galaxy_posx(j,2), galaxy_posy(j,2)
            sum += distance
        }
    print format_matrix(image) > "day11ee.txt"
    # print_matrix_dimensions(image)
    print "galaxies = "length(galaxies)
    print "sum = "sum
}
function galaxy_posx(    g,by,count,x) {
    x = galaxies[g]["x"]
    for (empty_col in empty_cols)
        if (int(empty_col) < int(x))
            count++
    return (x + (count * (by-1)))
}
function galaxy_posy(    g,by, count, y) {
    y = galaxies[g]["y"]
    for (empty_row in empty_rows)
        if (int(empty_row) < int(y))
            count++
    return (y + (count * (by-1)))
}
function galaxy_distance(    i,j,by,x1,y1,x2,y2) {
    x1 = galaxy_posx(i,by)
    y1 = galaxy_posy(i,by)
    x2 = galaxy_posx(j,by)
    y2 = galaxy_posy(j,by)
    return abs(x1-x2) + abs(y1-y2) # manhattan
}
function max(    x,y) { return (x>y)?x:y  }
function abs(    x)   { return (x<0)?-x:x }
function format_matrix(    arr, row, col, res) {
    for (row in arr) {
        for (col in arr[row])
            if (row in empty_rows || col in empty_cols)
                res = res " "
            else
                res = res sprintf(arr[row][col])
        res = res sprintf("\n")
    }
    return res
}
function print_matrix_dimensions(    arr) {
    printf "%dx%d\n", length(arr), length(arr[1])
}
