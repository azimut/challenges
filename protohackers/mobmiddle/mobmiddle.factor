USING: kernel accessors io io.streams.duplex io.sockets io.servers math.order io.encodings.ascii combinators.short-circuit sequences ascii splitting prettyprint continuations concurrency.messaging threads ;
IN: mobmiddle

CONSTANT: tonys-address "7YWHMfk9JZe0LM0g1ZauHuiSxhI"

: boguscoin? ( str -- ? )
    { [ length 25 36 between? ]
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
        proxy-rewrite over stream-print
        handle-readln
    ] when* ;

: handle-print ( stream -- stream )
    dup stream-readln [
        proxy-rewrite print
        handle-print
    ] when* ;

: connect-remote ( -- stream )
    "chat.protohackers.com" 16963 <inet>
    ascii <client> drop ;

: <mobmiddle-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ connect-remote >duplex-stream< ! in out
      [ [ handle-readln drop ] curry "req" spawn drop ]
      [ [ handle-print  drop ] curry "res" spawn drop ]
      bi*
      yield
    ] >>handler ;

: main ( -- )
    1234 <mobmiddle-server> start-server wait-for-server ;

MAIN: main
