BEGIN { FS="" }
{
    bank_max = 0
    for (i = 1; i <= NF-1; i++)
        for (j = i+1; j <= NF; j++)
            if (int($i$j) > bank_max)
                bank_max = int($i$j)
    total += bank_max
}
END { print total }
