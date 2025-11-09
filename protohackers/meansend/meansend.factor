USING: kernel accessors assocs byte-arrays arrays io io.servers io.encodings.binary combinators math math.parser math.statistics sequences prettyprint formatting namespaces serialize ;
IN: meansend

: dupdd ( x y z -- x x y z ) pick -rot ;
: filter-state ( state mint maxt -- state' ) '[ drop dup _ > swap _ < and ] assoc-filter ;
: assoc-mean ( assoc -- n ) values mean ;
: write-int32 ( n -- ) 1byte-array write flush ;
: cmd-query ( state mint maxt -- state' ) dupdd filter-state assoc-mean write-int32 ;
: cmd-insert ( state timestamp price -- state' ) 2array 1array append ;
: packet-switch ( state f1 f2 type -- state' )
   {
       { 73 [ cmd-insert ] } ! I
       { 81 [ cmd-query  ] } ! Q
   } case ;

: parse-int32 ( xs -- int32 )
    reverse dup length <iota> 0 [ 8 * shift + ] 2reduce ;
: packet-fields ( seq -- f1 f2 type )
    [ 1 5 rot subseq parse-int32 ] [ 4 tail* parse-int32 ] [ first ] tri ;

: process-packet ( state seq -- state' ) packet-fields packet-switch ;
: handler-loop ( state -- state' )
    9 read-partial [
        ! dup print flush
        ! packet-fields 3byte-array print flush
        process-packet
        flush
        handler-loop
    ] when*
    ! 9 read [ length "%d\n" printf flush handler-loop ] when*
    ! 9 read [ length number>string print flush handler-loop ] when*
    ;

: <meansend-server> ( port -- threaded-server )
    binary <threaded-server>
    swap >>insecure
    [ { } handler-loop ] >>handler ;

: main ( -- )
    1234 <meansend-server> start-server wait-for-server ;

MAIN: main
