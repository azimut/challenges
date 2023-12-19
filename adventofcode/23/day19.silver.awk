BEGIN { FS = "[,={}]"; name = 1 }
/^[a-z]+/ {
    ++wids
    wname2wid[$name] = wids
    wid2wname[wids] = $name
    for (rid = 2; rid <= NF-1; rid++)
        workflows[$name][rid-1] = $rid
}
/^{.*}/ {
    ++nparts
    for (xmas = 2; xmas <= NF - 1; xmas += 2)
        parts[nparts][$xmas] = $(xmas+1)
}
END {
    for (pid in parts) {
        rejected = accepted = 0
        for (wid = wname2wid["in"]; wid <= wids; wid++) {
            wname = wid2wname[wid]
            for (rid in workflows[wname]) {
                action = jumpto = ""
                rule = workflows[wname][rid]
                switch (rule) { # from the rule derive an action
                case />/ :
                    if (parts[pid][substr(rule, 1, 1)] > int(substr(rule, 3)))
                        action = substr(rule, 1+index(rule, ":"))
                    break
                case /</ :
                    if (parts[pid][substr(rule, 1, 1)] < int(substr(rule, 3)))
                        action = substr(rule, 1+index(rule, ":"))
                    break
                default :
                    action = rule
                    break
                }
                switch (action) {
                case "A"      : accepted = 1; sum += sumpart(pid); break
                case "R"      : rejected = 1; break
                case /[a-z]+/ : jumpto = action; break
                }
                if (jumpto) {
                    wid = wname2wid[jumpto]-1
                    break # exit rules
                }
                if (accepted || rejected) break # exit rules
            }
            if (accepted || rejected) break # exit workflows
        }
    }
    print "sum="sum
}
function sumpart(    pid) {
    return (parts[pid]["x"] + \
            parts[pid]["m"] + \
            parts[pid]["a"] + \
            parts[pid]["s"])
}
