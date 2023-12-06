/Time:/     { for (i = 2; i <= NF; i++) durations[i] = $i }
/Distance:/ { for (i = 2; i <= NF; i++) distance_records[i] = $i }
END {
    mult = 1
    for (idx in durations) { # foreach race
        count = 0
        for (t = 0; t <= durations[idx]; t++) # charging times
            if (t * (durations[idx] - t) > distance_records[idx])
                count++
        mult *= count
    }
    print mult
}
