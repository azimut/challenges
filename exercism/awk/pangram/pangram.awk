BEGIN { FPAT = "[[:alpha:]]" }
{
    for (i = 1; i <= NF; i++)
        letters[tolower($i)] = 1
}
END { print length(letters) == 26 ? "true" : "false" }
