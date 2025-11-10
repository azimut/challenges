USING: kernel accessors assocs arrays io io.servers io.encodings.binary combinators math math.statistics math.functions sequences prettyprint formatting namespaces serialize endian ;
IN: meansend

: packet-fields ( byte-array -- field1 field2 packet-type )
    [ 1 5 rot subseq be> ] [ 4 tail* be> ] [ first ] tri ;

: log-response ( x -- x )
    dup [ "--> %8x\n" printf flush ] with-global ; inline
: log-request ( x y z -- x y z )
    3dup [ "<-- %8x %8x %c\n" printf flush ] with-global ; inline

: dupdd ( x y z -- x x y z ) pick -rot ;
: filter-state ( state min max -- state' ) '[ drop dup _ >= swap _ <= and ] assoc-filter ;
: assoc-mean ( assoc -- n ) values mean round ;
: write-int32 ( n -- ) log-response 4 >be write ;
: cmd-query ( state min max -- state' ) dupdd filter-state assoc-mean write-int32 ;
: cmd-insert ( state timestamp price -- state' ) 2array 1array append ;
: packet-switch ( state f1 f2 type -- state' )
    log-request
    {
        { 73 [ cmd-insert ] } ! I
        { 81 [ cmd-query  ] } ! Q
    } case ;

: process-packet ( state seq -- state' ) packet-fields packet-switch ;
: handler-loop ( state -- state' )
    9 read [ process-packet flush handler-loop ] when* ;

: <meansend-server> ( port -- threaded-server )
    binary <threaded-server>
    swap >>insecure
    [ { } handler-loop ] >>handler ;

: main ( -- )
    1234 <meansend-server> start-server wait-for-server ;

MAIN: main
