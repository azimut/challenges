BEGIN { FS = "[:|]" }
{
    wins = 0
    for (w = 1; w <= split($2, winners, " "); w++)
        for (o = 1; o <= split($3, owns, " "); o++)
            if (winners[w] == owns[o])
                wins++
    scratchcards[NR] = wins
}
END {
    for (sid in scratchcards) {
        counts[sid] += 1
        for (i = sid+1; i <= sid+scratchcards[sid]; i++)
            counts[i] += counts[sid]
    }
    for (c in counts) sum += counts[c]
    print sum
}
