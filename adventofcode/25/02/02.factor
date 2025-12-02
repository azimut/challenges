USING: kernel peg.ebnf multiline ranges math math.parser io.files io.encodings.ascii splitting sequences sequences.extras strings pcre namespaces ;
IN: 02

EBNF: parse [=[
    n     = [0-9]+            => [[ dec> ]]
    entry = n:a "-"~ n:b ","? => [[ a b [a..b] ]]
    main  = entry+
]=]

: invalid-id? ( n -- ? )
    >dec
    [ dup length 2 /i tail-slice ]
    [ dup length 2 /i head-slice ]
    bi = ;

: part1 ( filename -- n )
    ascii file-contents parse [
        [ invalid-id? ] filter
    ] map-concat sum ;

SYMBOL: invalid-regex
invalid-regex [ "^([0-9]+)\\1+$" <compiled-pcre> ] initialize

: part2 ( filename -- n )
    ascii file-contents parse [
        [ >dec invalid-regex get-global matches? ] filter
    ] map-concat sum ;
