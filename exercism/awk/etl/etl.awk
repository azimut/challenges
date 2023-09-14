BEGIN { FPAT = "[[:alnum:]]+"; OFS = "," }
{
    for (i = 2; i <= NF; i++)
        scores[tolower($i)] = $1
}
END {
    PROCINFO["sorted_in"] = "@ind_str_asc"
    for (letter in scores)
        print letter, scores[letter]
}
