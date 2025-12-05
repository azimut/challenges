USING: kernel io.files io.encodings.ascii splitting peg.ebnf multiline math.parser ranges sequences sets shuffle math arrays sorting combinators math.order ;
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

: in-range? ( ranges n -- ? )
    '[ _ swap in? ] any? ;

: part1 ( ranges numbers -- n )
    [ dupd in-range? ] count nip ;

: merge-ranges ( range range -- seq-ranges )
    { { [ 2dup set=        ] [ drop 1array ] }
      { [ 2dup intersects? ] [
            [ [ minimum ] bi@ min ] [ [ maximum ] bi@ max ] 2bi
            [a..b] 1array
        ] }
      [ 2array ] } cond ;

: part2 ( ranges numbers -- n )
    drop [ minimum ] sort-by
    { } [ over empty? [
              prefix
          ] [
              [ unclip-last ] dip
              merge-ranges
              append
          ] if
    ] reduce
    [ cardinality ] map-sum ;
