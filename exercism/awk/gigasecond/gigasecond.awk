BEGIN { GIGASECOND=1e9; FS="[-T:]" }

{
    current = mktime(sprintf("%s %s %s %d %d %d", $1, $2, $3, $4, $5, $6), 1)
    print strftime("%FT%T", current+GIGASECOND, 1)
}
