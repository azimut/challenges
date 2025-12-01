USING: kernel io io.files io.encodings.ascii peg.ebnf math.parser strings sequences combinators math math.functions multiline sequences.extras ;
IN: 01

EBNF: parse [=[
    num  = [0-9]+ => [[ dec> ]]
    dir  = [LR]   => [[ 1string ]]
    main = dir num
]=]

: turn-dial ( prev pair -- next )
    [ second ] [ first ] bi {
        { "L" [ - 100 rem ] }
        { "R" [ + 100 rem ] }
    } case ;

: part1 ( filename -- n )
    ascii file-lines [ parse ] map
    50 [ turn-dial ] accumulate*
    [ zero? ] count ;

: turns ( pair -- val )
    [ second ] [ first ] bi {
        { "L" [ neg ] }
        { "R" [     ] }
    } case ;

: part2 ( filename -- n )
    ascii file-lines [ parse ] map
    [ turns ] map
    [ dup abs swap '[ _ signum ] replicate ] map-concat
    50 [ + 100 rem ] accumulate*
    [ zero? ] count
    ;
