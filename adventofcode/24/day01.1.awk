{
    left[i++] = $1; right[j++] = $2;
}

END {
    asort(left, left); asort(right, right)
    for (i = 0; i < length(left); i++)
        total_distance += abs(left[i] - right[i])
    print total_distance
}

function abs(a) { return a > 0 ? a : (- a) }
