match($0, /([0-9]+)\|([0-9]+)/, rule) { ordering_rules[rule[2]][rule[1]] = 1 }

/,/ {
    ordered = 1
    npages = split($0, pages, ",")

    for (p = 1; p <= npages - 1; p++) {
        for (pp = p + 1; pp <= npages; pp++) {
            if (printed_after(pages[p], pages[pp])) {
                ordered = 0
                tmp = pages[p]
                pages[p] = pages[pp]
                pages[pp] = tmp
            }
        }
    }

    if (!ordered) middle_sum += pages[int(npages / 2 + 0.5)]
}

END { print "middle_sum = " middle_sum }

function printed_after(    first, second) {
    return first in ordering_rules && second in ordering_rules[first]
}
