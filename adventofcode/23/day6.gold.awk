BEGIN { FPAT = "[0-9]+" }

      { gsub(/ /, "") }
 NR~1 { time   = $1 }
 NR~2 { record = $1 }

END {
    mult = 1
    for (t = 0; t <= time; t++) # charging times
        if (t * (time - t) > record)
            count++
    mult *= count
    print mult
}
