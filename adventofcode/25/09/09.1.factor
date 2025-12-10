USING: kernel peg.ebnf multiline io.files io.encodings.ascii math.parser sequences math.combinatorics math.vectors math arrays sorting ;
IN: 09.1

EBNF: parse-line [=[
    n    = [0-9]+ => [[ dec> ]]
    main = n ","~ n
]=]

: area ( p1 p2 -- area ) v- vabs { 1 1 } v+ product ;
: parse ( filename -- xs )
    ascii file-lines [ parse-line ] map ;

: part1 ( xs -- n )
    2 [ dup first2 area 2array ] map-combinations
    [ second ] sort-by
    last second ;
