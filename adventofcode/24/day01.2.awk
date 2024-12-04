{
    left[i++] = $1; rightMap[$2]++;
}

END {
    for (i = 0; i < length(left); i++)
        similarity_score += left[i] * (left[i] in rightMap ? rightMap[left[i]] : 0)
    print similarity_score
}
