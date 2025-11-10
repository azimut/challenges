USING: accessors ascii assocs combinators.short-circuit channels formatting io io.encodings.ascii io.servers kernel math sequences strings namespaces prettyprint ;
IN: budgetchat

SYMBOL: user-channels
user-channels [ H{ } clone ] initialize

: greet ( -- )
    "Welcome to budgetchat! What shall I call you?" print flush ;

: validate-user ( user -- user/f )
    dup { [ string? ] [ length 0 > ] [ [ alpha? ] all? ] } 1&&
    swap and ;
: read-user ( -- user/f ) readln validate-user ;
: register-user ( user -- )
    dup user-channels get-global key? [ drop ] [
        user-channels get-global <channel> -rot set-at
    ] if ;

: print-msg ( user msg -- ) "[%s] %s\n" printf flush ;
: room-loop ( user -- user )
    readln [
        dupd print-msg room-loop
    ] when* ;

: handle-requests ( -- )
    greet read-user [
        dup register-user room-loop drop
    ] when* ;

: <budgetchat-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ handle-requests ] >>handler ;

: main ( -- )
    1234 <budgetchat-server> start-server wait-for-server ;

MAIN: main
