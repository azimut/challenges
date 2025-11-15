USING: kernel io io.sockets io.encodings.ascii destructors namespaces assocs splitting sequences io.encodings.string combinators accessors namespaces ascii formatting ;
IN: unusualdb

SYMBOL: the-database
the-database [ H{ { "version" "Ken's Key-Value Store 1.0" } } clone ] initialize

: db ( -- db ) the-database get-global ;
: db-set ( value key -- ) db set-at ;
: db-get ( key -- value ) db at "" or ;

TUPLE: insert key value ;
TUPLE: retrieve key ;
: <insert> ( str -- insert ) "=" split1 "" or insert boa ;
: <retrieve> ( str -- retrieve ) retrieve boa ;

: has-equal? ( str -- ? ) CHAR: = swap member? ;
: request-decode ( bytes -- request )
    ascii decode
    [ blank? ] trim
    [ has-equal? ] keep
    swap [ <insert> ] [ <retrieve> ] if ;

: request-response ( request -- response/f )
    { { [ dup insert?   ] [
            [ value>> ] [ key>> ] bi
            dup "version" = [ 2drop ] [ db-set ] if
            f
        ]
      }
      { [ dup retrieve? ] [ key>> dup db-get "%s=%s" sprintf ascii encode ] }
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
