BEGIN { FS = "[:|]" }
{
    points = p = 0
    for (w = 1; w <= split($2, winners, " "); w++)
        for (o = 1; o <= split($3, owns, " "); o++)
            if (winners[w] == owns[o])
                points = 2^p++
    sum += points
}
END { print sum }
