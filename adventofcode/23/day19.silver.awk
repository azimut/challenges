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
    for (wid in wid2wname) {
        print wid, wid2wname[wid]
    }
    for (pid in parts) {
        rejected = accepted = 0
        # print "pid="pid,spart(pid)
        for (wid = wname2wid["in"]; wid <= wids; wid++) {
            wname = wid2wname[wid]
            # print "pid="pid,"wid="wid,"wname="wname
            for (rid in workflows[wname]) {
                action = jumpto = ""
                rule = workflows[wname][rid]
                # print "pid="pid,"wid="wid,"wname="wname,"rule="rule
                switch (rule) { # from the rule derive an action
                case />/ :
                    print ">",xmas,value, parts[pid][xmas]
                    xmas = substr(rule, 1, 1)
                    value = int(substr(rule, 3))
                    if (parts[pid][xmas] > value)
                        action = substr(rule, 1+index(rule, ":"))
                    break
                case /</ :
                    xmas = substr(rule, 1, 1)
                    value = int(substr(rule, 3))
                    print "<", xmas,value, parts[pid][xmas]
                    if (parts[pid][xmas] < value)
                        action = substr(rule, 1+index(rule, ":"))
                    break
                default : action = rule; break
                }
                switch (action) {
                case "A" : accepted = 1; sum += sumpart(pid); break
                case "R" : rejected = 1; break
                case /[a-z]+/ : jumpto = action; break
                }
                if (jumpto) {
                    wid = wname2wid[jumpto]-1
                    print wid, wid2wname[wid+1]
                    break # exit rules
                }
                if (accepted || rejected) break # exit rules
            }
            if (accepted || rejected) break
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
function spart(   pid) {
    return sprintf("x=%d,m=%d,a=%d,s=%d",parts[pid]["x"],parts[pid]["m"],parts[pid]["a"],parts[pid]["s"])
}
