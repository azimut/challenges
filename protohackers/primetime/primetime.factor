USING: kernel prettyprint math math.primes json assocs assocs.extras linked-assocs accessors io.servers io.encodings.ascii io sequences continuations ;
IN: primetime

: assert-request ( json -- json )
    dup [ "number" of ] [ "method" of ] bi
    "isPrime" assert=
    number? t assert= ;

: is-prime? ( number -- ? ) [ float? ] [ drop f ] [ prime? ] 1if ;
: raw-response ( -- response ) LH{ { "method" "isPrime" } } ;
: make-response ( number  -- response )
    raw-response "prime" rot is-prime? set-of ;

: r2r ( json -- 'json )
    json>
    assert-request
    "number" of make-response
    >json ;

: handle-json-request ( str -- 'str )
    [ r2r ] [ 2drop "{\"error\":\"r2r failed!\"}" ] recover ;
: handle-json-requests  ( -- )
    [ readln ] [ handle-json-request print flush ] while* ;

: <primetime-server> ( -- threaded-server )
    ascii <threaded-server>
    "primetime-server" >>name
    1234 >>insecure
    [ handle-json-requests ] >>handler ;

: main ( -- ) <primetime-server> start-server wait-for-server ;

MAIN: main
