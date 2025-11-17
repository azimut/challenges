USING: kernel environment pack base64 sequences sequences.extras assocs json linked-assocs http.client io.encodings.string io.encodings.ascii prettyprint command-line ;
IN: helpmeunpack

: base-url ( token -- url )
    "https://hackattic.com/challenges/help_me_unpack/problem?access_token="
    prepend ;

: request ( token -- str-base64 )
    base-url
    http-get nip
    ascii decode json>
    "bytes" of ;

: as-le ( bytes -- seq ) "iIssfdd" unpack-le 3 remove-nth-of 1 head* ;
: as-be ( bytes -- seq ) "iIssfdd" unpack-be 1 tail* ;
: unpacking ( bytes -- seq ) [ as-le ] [ as-be ] bi append ;
: response ( str-base64 -- str-json )
    { "int" "uint" "short" "float" "double" "big_endian_double" }
    swap base64> unpacking
    zip
    >linked-hash
    >json ;

: send-response ( str-json token -- reply )
    "https://hackattic.com/challenges/help_me_unpack/solve?access_token=" prepend
    http-post nip
    ascii decode ;

: main ( -- )
    command-line get [
        [ request response ] keep
        send-response
        print
    ] unless-empty ;

MAIN: main
