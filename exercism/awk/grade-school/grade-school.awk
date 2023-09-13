BEGIN { FS = ","; PROCINFO["sorted_in"] = "@ind_str_asc" }

!($1 in names) { roster[$2][$1] = 1; names[$1] = 1 }

END   {
    if (action == "roster")
        for (g in roster)
            for (n in roster[g])
                printf latch++ ? ",%s" : "%s", n
    if (action == "grade" && grade in roster)
        for (n in roster[grade])
            printf latch++ ? ",%s" : "%s", n
}
