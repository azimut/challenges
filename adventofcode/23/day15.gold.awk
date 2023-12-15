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
    if (box in boxes)  # replace it
        for (idx in boxes[box])
            if (exists(box,idx,label)) {
                boxes[box][idx][label] = focalLength
                next # !!
            }
    boxes[box][length(boxes[box])+1][label] = focalLength # insert it
}
END {
    # print format_boxes()
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
function focusing_power(    result) {
    for (box in boxes)
        for (slot in boxes[box])
            for (label in boxes[box][slot])
                result += (1+box) * slot * boxes[box][slot][label]
    return result
}
function format_graph(    result, partial) {
    for (box = 0; box <= 255; box++) {
        partial = ""
        if (box in boxes)
            for (sid in boxes[box])
                for (label in boxes[box][sid])
                    partial = partial "#"
        result = result sprintf("%16s\n", partial)
    }
    return result
}
function format_boxes(    result) {
    for (box in boxes) {
        result = result sprintf("Box %3d:", box)
        for (sid in boxes[box])
            for (label in boxes[box][sid])
                result = result sprintf(" [%s %d]", label, boxes[box][sid][label])
        result = result "\n"
    }
    return result
}
