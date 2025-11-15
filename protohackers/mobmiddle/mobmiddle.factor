USING: kernel accessors io io.streams.duplex io.sockets io.servers math.order io.encodings.ascii combinators.short-circuit sequences ascii splitting prettyprint continuations concurrency.messaging threads namespaces destructors ;
IN: mobmiddle

CONSTANT: tonys-address "7YWHMfk9JZe0LM0g1ZauHuiSxhI"

: boguscoin? ( str -- ? )
    { [ length 26 35 between? ]
      [ first CHAR: 7 = ]
      [ [ alpha? ] all? ]
    } 1&& ;
: boguscoin-replace ( str -- str' )
    dup boguscoin? [ drop tonys-address ] when ;

: words ( str -- seq ) " " split ;
: unwords ( seq -- str ) " " join ;
: proxy-rewrite ( str -- str' )
    words [ boguscoin-replace ] map unwords ;

: handle-readln ( stream -- stream )
    readln [
        proxy-rewrite
        over [ stream-print ] [ stream-flush ] bi
        handle-readln
    ] when* ;

: handle-print ( stream -- stream )
    dup stream-readln [
        proxy-rewrite
        print flush
        handle-print
    ] when* ;

: connect-remote ( -- duplex-stream )
    ! "127.0.0.1" 1234 <inet>
    "chat.protohackers.com" 16963 <inet>
    ascii <client> drop ;

: <mobmiddle-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ connect-remote [
          [ '[ _ handle-print ] in-thread ]
          [ handle-readln ]
          bi
      ] with-disposal
    ] >>handler ;

: main ( -- )
    4321 <mobmiddle-server> start-server wait-for-server ;

MAIN: main
