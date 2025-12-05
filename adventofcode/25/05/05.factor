USING: kernel io.files io.encodings.ascii splitting peg.ebnf multiline math.parser ranges sequences sets shuffle math accessors hash-sets namespaces ;
IN: 05

EBNF: parse-range [=[
    id    = [0-9]+         => [[ dec> ]]
    range = id:a "-"~ id:b => [[ a b [a..b] ]]
]=]

: parse ( filename -- ranges numbers )
    ascii file-lines { "" } split1
    [ [ parse-range ] map ]
    [ [ dec>        ] map ]
    bi* ;

: in-ranges? ( ranges n -- ? ) '[ _ swap in? ] any? ;
: add-when-in-range ( ranges count n -- count ) swapd in-ranges? [ 1 + ] when ;
: part1 ( ranges numbers -- n )
    0 [ dupdd add-when-in-range ] reduce nip ;

SYMBOL: fresh-ids
fresh-ids [ HS{ } clone ] initialize

: part2 ( ranges numbers -- n )
    drop [
        members [
            fresh-ids get-global adjoin
        ] each
    ] each
    fresh-ids get-global cardinality ;
