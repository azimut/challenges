BEGIN { FS="" }

NF == 0              { print "series cannot be empty"; exit 2 }
len <= 0 || len > NF { print "invalid length"; exit 2 }

{ for (i = 1; i <= NF-len+1; i++)
        printf(i == 1 ? "%s" : " %s", substr($0, i, len)) }
