BEGIN   { FS = ""; GALAXY = "#"; EMPTY = "."}
/^\.+$/ { empty_rows[NR] = 1; print "empty_row = "NR }
        { for (i = 1; i <= NF; i++) image[NR+roffset][i] = $i }
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
        for (j = i+1; j <= length(galaxies); j++)
            sum += galaxy_distance(i,j,1000000) # CHANGEME
    print "galaxies = "length(galaxies), "sum = "sum
}
function galaxy_posx(    g,by,count,x) {
    x = galaxies[g]["x"]
    for (empty_col in empty_cols)
        if (int(empty_col) < int(x)) # !
            count++
    return (x + (count * (by-1)))
}
function galaxy_posy(    g,by, count, y) {
    y = galaxies[g]["y"]
    for (empty_row in empty_rows)
        if (int(empty_row) < int(y)) # !
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
function abs(    x)   { return (x<0)?-x:x }
