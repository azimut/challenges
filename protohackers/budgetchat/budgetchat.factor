USING: accessors ascii assocs combinators.short-circuit concurrency.mailboxes formatting io io.encodings.ascii io.servers kernel math sequences strings namespaces prettyprint threads ;
IN: budgetchat

SYMBOL: users-mailboxes
users-mailboxes [ H{ } clone ] initialize

: mailboxes ( -- mailboxes ) users-mailboxes get-global ; inline
: mailboxes-not-of ( user -- seq ) '[ drop _ = not ] mailboxes swap assoc-filter values ;
: mailbox-of ( user -- mailbox/f ) mailboxes at ;
: mailbox-init ( user -- ) mailboxes <mailbox> -rot set-at ;
: mailbox-deliver ( user msg -- )
    '[ _ swap mailbox-put ]
    swap mailboxes-not-of
    swap each ;

: greet ( -- )
    "Welcome to budgetchat! What shall I call you?" print flush ;

: user-validate ( user -- user/f )
    dup { [ string? ] [ length 0 > ] [ [ alpha? ] all? ] } 1&&
    swap and ;
: user-read ( -- user/f ) readln user-validate ;
: user-register ( user -- )
    dup mailboxes key? [ drop ] [ mailbox-init ] if ;

: msg-new ( user raw-msg -- msg ) "[%s] %s" sprintf ;
: msg-enter ( user -- msg ) "* %s has entered the room" sprintf ;
: room-loop ( user -- user )
    readln [
        ! dupd msg-new mailbox-deliver
        drop
        room-loop
    ] when* ;

: watch-loop ( mailbox -- mailbox ) dup mailbox-get print flush watch-loop ;
: watch-loop-spawn ( user mailbox -- ) '[ _ watch-loop ] swap spawn drop ;
: watch-mailbox ( user -- ) dup mailbox-of [ watch-loop-spawn ] [ drop ] if* ;

: handle-requests ( -- )
    greet user-read [
        dup user-register
        dup dup msg-enter mailbox-deliver
        dup watch-mailbox
        room-loop drop
    ] when* ;

: <budgetchat-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ handle-requests ] >>handler ;

: main ( -- )
    1234 <budgetchat-server> start-server wait-for-server ;

MAIN: main
