@include "ord"
BEGIN { RS="[,\n]" }
      { split($0,parts,"[=-]"); label = parts[1]; box = hash(label); }
      # { printf "After \"%s\"\n", $0 }
/-/ {
    found = -1
    if (box in boxes)
        for (idx in boxes[box])
            if (exists(box,idx,label))
                found = idx
    if (found != -1) { # shrink
        oldsize = length(boxes[box])
        # delete boxes[box][found] # rm slot in box
        for (i = found; i < oldsize; i++) {
            delete boxes[box][i] # otherwise you will have 2 entries for "i"
            l = first(boxes[box][i+1])
            boxes[box][i][l] = boxes[box][i+1][l]
        }
        delete boxes[box][oldsize] # delete old last one
        if (oldsize == 1)
            delete boxes[box]
    }
}
/=/ {
    focalLength = parts[2];
    if (box in boxes) {  # replace it
        for (idx in boxes[box])
            if (exists(box,idx,label)) {
                boxes[box][idx][label] = focalLength
                next # !!
            }
    }
    boxes[box][length(boxes[box])+1][label] = focalLength # insert it
}
# {
#     print format_boxes()
# }
END {
    print format_boxes()
    print focusing_power()
}
function first(arr) { for (idx in arr) return idx }
function exists(    bid, idx, label) {
    return ((bid in boxes) && (idx in boxes[bid]) && (label in boxes[bid][idx]))
}
function hash(input,    current, arr) {
    for (i = 1; i <= split(input,arr,""); i++) {
        current += ord(arr[i])
        current *= 17
        current %= 256
    }
    return current
}
function format_boxes() {
    for (box in boxes) {
        printf "Box %d:", box
        for (sid in boxes[box])
            for (label in boxes[box][sid])
                printf " [%s %d]", label, boxes[box][sid][label]
        print ""
    }
}
function focusing_power(    result) {
    for (box in boxes) {
        for (slot in boxes[box]) {
            for (label in boxes[box][slot]) {
                result += (1+box) * slot * boxes[box][slot][label]
            }
        }
    }
    return result
}
