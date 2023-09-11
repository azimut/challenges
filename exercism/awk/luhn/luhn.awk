/ /                     { gsub(/ /, "") }
/[^0-9 ]/ || length < 2 { print "false"; next }

{
    for (i = length; i > 0; i--) {
        n = substr($0, i, 1)
        if ((length - i) % 2)
            sum += n*2 > 9 ? n*2 - 9 : n*2
        else
            sum += n
    }
    print (sum % 10 == 0) ? "true" : "false"
}
