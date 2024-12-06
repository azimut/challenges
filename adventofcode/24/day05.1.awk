match($0, /([0-9]+)\|([0-9]+)/, rule) { ordering_rules[rule[1]][rule[2]] = 1 }

/,/ {
    ordered = 1
    npages = split($0, pages, ",")

    for (i in pages)
        for (lesser in ordering_rules)
            if (lesser == pages[i]) {
                for (k = i - 1; k <= npages && k > 0; k--)
                    if (pages[k] in ordering_rules[lesser]) ordered = 0
            }

    if (ordered) middle_sum += pages[int(npages / 2 + 0.5)]
}

END { print "middle_sum = " middle_sum }
