BEGIN { FS = "[ =,\\(\\)]"; node=1; left=5; right=7 }
NR==1 { ninstructions = split($0, instructions, "") }
NR>2  {
    network[$node]["L"] = $left
    network[$node]["R"] = $right
}
END {
    current_node = "AAA"
    while (1) {
        current_node = network[current_node][(instructions[(j++%ninstructions)+1])]
        if (current_node == "ZZZ")
            break
    }
    print j
}
