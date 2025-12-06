USING: kernel io.files io.encodings.ascii sequences peg.ebnf multiline math.parser math math.matrices ;
IN: 06.1

EBNF: parse-line [=[
    n    = [0-9]+ => [[  dec> ]]
    pad  = (" "*)~
    main = (pad (n|"*"|"+") pad)+
]=]

: parse ( filename -- xss operators )
    ascii file-lines
    [ parse-line ] map
    unclip-last
    [ transpose ] dip ;

: part1 ( xss operators -- n )
    [ "*" = [ product ] [ sum ] if ] 2map sum ;
