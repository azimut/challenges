USING: kernel io io.files io.encodings.ascii peg.ebnf math.parser strings sequences combinators math math.functions multiline sequences.extras ;
IN: 01

EBNF: parse [=[
    left  = "L"~ [0-9]+ => [[ dec> neg ]]
    right = "R"~ [0-9]+ => [[ dec>     ]]
    main = left | right
]=]

: part1 ( filename -- n )
    ascii file-lines [ parse ] map
    50 [ + 100 rem ] accumulate*
    [ zero? ] count ;

: part2 ( filename -- n )
    ascii file-lines [ parse ] map
    [ dup abs swap '[ _ signum ] replicate ] map-concat
    50 [ + 100 rem ] accumulate*
    [ zero? ] count ;
