USING: accessors ascii assocs combinators.short-circuit concurrency.mailboxes formatting io io.encodings.ascii io.servers kernel math sequences strings namespaces prettyprint threads continuations calendar ;
IN: budgetchat

SYMBOL: users-mailboxes
users-mailboxes [ H{ } clone ] initialize

: mailboxes ( -- mailboxes ) users-mailboxes get-global ; inline
: mailboxes-not-of ( user -- seq ) '[ drop _ = not ] mailboxes swap assoc-filter values ;
: mailbox-of ( user -- mailbox/f ) mailboxes at ;
: mailbox-init ( user -- ) mailboxes <mailbox> -rot set-at ;
: mailbox-delete ( user -- ) mailboxes delete-at ;
: mailbox-deliver ( user msg -- )
    '[ _ swap mailbox-put ]
    swap mailboxes-not-of
    swap each ;

: msg-new ( user raw-msg -- msg ) "[%s] %s" sprintf ;
: msg-enter ( user -- msg ) "* %s has entered the room" sprintf ;
: msg-invalid ( -- msg ) "* Illegal username :( ... bye!" ;
: msg-list ( user -- msg )
    '[ _ = not ] mailboxes keys swap filter
    ", " join
    "* The room contains: %s" sprintf ;
: msg-leave ( user -- msg ) "* %s has left the room" sprintf ;
: msg-greet ( -- ) "Welcome to budgetchat! What shall I call you?" ;

: user-validate ( user -- user/f )
    dup { [ string? ] [ length 0 > ] [ [ alpha? ] all? ] } 1&&
    swap and ;
: user-read ( -- user/f ) readln user-validate ;
: user-leave ( user -- ) dup msg-leave mailbox-deliver ;
: user-register ( user -- )
    dup mailboxes key? [ drop ] [ mailbox-init ] if ;

: room-loop ( user -- user )
    readln [
        dupd dupd msg-new mailbox-deliver
        room-loop
    ] when* ;

: watch-loop ( mailbox -- mailbox ) dup mailbox-get [ print flush watch-loop ] when* ;
: watch-loop-spawn ( user mailbox -- ) '[ _ watch-loop ] swap spawn drop ;
: watch-mailbox ( user -- ) dup mailbox-of [ watch-loop-spawn ] [ drop ] if* ;

: mailbox-ctrlaltdel ( user -- ) mailbox-of [ f swap mailbox-put ] when* ;
: user-cleanup ( user -- ) [ mailbox-ctrlaltdel ] [ mailbox-delete ] [ user-leave ] tri ;

: handle-requests ( -- )
    greet print flush user-read [
        [ dup user-register
          dup dup msg-enter mailbox-deliver
          dup watch-mailbox
          dup msg-list print flush
          room-loop
        ] [ user-cleanup ] finally
    ] [ msg-invalid print flush ] if* ;

: <budgetchat-server> ( port -- threaded-server )
    ascii <threaded-server>
    swap >>insecure
    [ handle-requests ] >>handler ;

: main ( -- )
    1234 <budgetchat-server> start-server wait-for-server ;

MAIN: main
