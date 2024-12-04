{
    direction = sign($1 - $2)
    for (level = 1; level < NF; level++) {
        dt = $(level) - $(level+1)
        if (abs(dt) < 1 || abs(dt) > 3 || direction != sign(dt))
            next
    }
    safe_reports++
}
END {
    print safe_reports
}

function sign(a) { return a > 0 }
function abs(a) { return a > 0 ? a : (- a) }
