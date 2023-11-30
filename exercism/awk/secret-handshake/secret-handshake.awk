{
    if (and($1,1)) handshake[++steps] = "wink";
    if (and($1,2)) handshake[++steps] = "double blink";
    if (and($1,4)) handshake[++steps] = "close your eyes";
    if (and($1,8)) handshake[++steps] = "jump";
    if (and($1,16))
        for (j = steps; j > 0;)
            printf bar++?",%s":"%s", handshake[j--]
    else
        while (k < steps)
            printf baz++?",%s":"%s", handshake[++k]
}
