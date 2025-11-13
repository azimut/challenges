USING: kernel io io.sockets io.encodings.ascii destructors namespaces assocs splitting sequences io.encodings.string combinators accessors namespaces ascii ;
IN: unusualdb

SYMBOL: the-database
the-database [ H{ } clone ] initialize

: db ( -- db ) the-database get-global ;
: db-set ( value key -- ) db set-at ;
: db-get ( key -- value ) db at "" or ;

TUPLE: insert key value ;
TUPLE: retrieve key ;
: <insert> ( str -- insert ) "=" split1 "" or insert boa ;
: <retrieve> ( str -- retrieve ) retrieve boa ;

: has-equal? ( str -- ? ) 61 swap member? ;
: request-decode ( bytes -- request )
    ascii decode
    [ blank? ] trim
    [ has-equal? ] keep
    swap [ <insert> ] [ <retrieve> ] if ;

: request-response ( request -- response/f )
    { { [ dup insert?   ] [ [ value>> ] [ key>> ] bi db-set f ] }
      { [ dup retrieve? ] [ key>> [ dup dup db-get "%s=%s\n" printf flush ] with-global db-get ascii encode ] }
    } cond ;

: serve ( datagram -- )
    [ receive ] keep !  bytes addrspec datagram
    [ request-decode request-response ] 2dip
    pick [ send ] [ 3drop ] if ;

: main ( -- )
    f 1234 <inet4> <datagram> [
        [ dup serve t ] loop drop
    ] with-disposal ;

MAIN: main
