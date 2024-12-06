match($0, /([0-9]+)\|([0-9]+)/, rule) {
    oidx++
    ordering_rules[oidx][1] = rule[1]
    ordering_rules[oidx][2] = rule[2]
}

/,/ {
    ordered = 1
    npages = split($0, pages, ",")

    for (i in pages)
        for (j in ordering_rules)
            if (ordering_rules[j][1] == pages[i]) {
                for (k = i - 1; k <= npages && k > 0; k--)
                    if (pages[k] == ordering_rules[j][2]) { ordered = 0 }
            }

    if (ordered) middle_sum += pages[int(npages / 2 + 0.5)]
}

END { print "middle_sum = " middle_sum }
