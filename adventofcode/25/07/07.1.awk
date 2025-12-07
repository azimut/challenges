function isEmpty()    { return _idx == 0 }
function push(el)     { stack[++_idx] = el }
function pop(    tmp) { if(!(_idx in stack)) return; tmp = stack[_idx]; delete stack[_idx--]; return tmp }

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
END {
    push(startx","starty)
    while(!isEmpty()) {
        split(pop(),curr,",")
        x = int(curr[1])
        y = int(curr[2])
        # print x,y
        while((++x <= NR) && (y > 0) && (y <= NF)) {
            # print "> ", x, y, diagram[x][y]
            if (diagram[x][y] == "^") {
                if (!((x","y) in visited_splitters)) {
                    push(x","y+1)
                    push(x","y-1)
                    visited_splitters[x","y] = 1
                }
                y = -10
            }
        }
    }
    print length(visited_splitters)
}
