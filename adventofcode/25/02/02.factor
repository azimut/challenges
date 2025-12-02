USING: kernel peg.ebnf multiline ranges math math.parser io.files io.encodings.ascii splitting sequences sequences.extras strings ;
IN: 02

EBNF: parse [=[
    n     = [0-9]+            => [[ dec> ]]
    entry = n:a "-"~ n:b ","? => [[ a b [a..b] ]]
    main  = entry+
]=]

: valid-id? ( n -- ? )
    >dec
    [ dup length 2 /i tail-slice ]
    [ dup length 2 /i head-slice ]
    bi = ;

: part1 ( filename -- n )
    ascii file-contents parse [
        [ valid-id? ] filter
    ] map-concat sum ;
