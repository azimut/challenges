USING: kernel io.encodings.ascii io.encodings.string io.files sequences math.matrices splitting ascii math.parser ;
IN: 06.2

: words ( str -- seq ) " " split harvest ;
: parse ( filename -- xss ops )
    ascii file-lines unclip-last words [
        transpose
        [ ascii decode ] map
        [ [ blank? ] all? ] split-when
        [ [ [ blank? ] reject dec> ] map ] map
    ] dip ;

: part2 ( xss ops -- n )
    [ "+" = [ sum ] [ product ] if ] 2map sum ;
