/[[:digit:]]+/ { latest = scores[NR] = $0; best = ($0 > best) ? $0 : best }
/list/         { for (s in scores) print scores[s] }
/latest/       { print latest }
/personalBest/ { print best }
/personalTopThree/ {
    n = asort(scores, sscores)
    for (i = n; i > n-3; i--)
        print sscores[i]
}
