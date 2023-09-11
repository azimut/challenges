BEGIN { GIGASECOND=1e9; FS="[-T:]" }

{
    current = mktime(sprintf("%s %s %s %02d %02d %02d", $1, $2, $3, $4, $5, $6), 1)
    future = current + GIGASECOND
    print strftime("%FT%T", future, 1)
}
