BEGIN   { FS = "[ =,()]"; node=1; left=5; right=7 }
NR == 1 { ninstructions = split($0, instructions, "") }
NR >= 3 {
    network[$node]["L"] = $left
    network[$node]["R"] = $right
    if (substr($node, length($node), 1) == "A") {
        print "->"$node
        starts[++nstarts] = $node
    }
}
END {
    done = 0
    while (!done) {
        endings = 0
        inst = instructions[(count++%ninstructions)+1]
        for (idx in starts) {
            tmp = starts[idx] = network[starts[idx]][inst]
            if (substr(tmp, 3, 1) == "Z") {
                endings++
                print "endint a, count="count,"tmp="tmp,"idx="idx
                counts[++c] = count
                if (length(counts) == nstarts)
                    done = 1
            }
        }
    }
    res = 1
    for (i = 1; i <= length(counts); i++) {
        print "trying lcm("res","counts[i]")"
        res = lcm(res, counts[i])
    }
    print count, res
}
function lcm(    a, b, greater, result) {
    greater = (a>b) ? a : b
    while(1) {
        if (((greater % a) == 0) && ((greater % b) == 0))  {
            result = greater
            break
        }
        greater++
    }
    return result
}
