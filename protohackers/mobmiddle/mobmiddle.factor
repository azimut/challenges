USING: kernel accessors io io.sockets io.servers math.order io.encodings.ascii combinators.short-circuit sequences ascii splitting prettyprint continuations ;
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

: handle-requests ( stream -- stream )
    readln [
        proxy-rewrite over stream-print
        handle-requests
    ] when* ;

: connect-remote ( -- stream )
    "chat.protohackers.com" 16963 <inet>
    ascii <client> drop ;

: <mobmiddle-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ connect-remote handle-requests ] >>handler ;

: main ( -- )
    1234 <mobmiddle-server> start-server wait-for-server ;

MAIN: main
