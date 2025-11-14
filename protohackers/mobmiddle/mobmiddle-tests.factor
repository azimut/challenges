USING: kernel mobmiddle tools.test ;
IN: mobmiddle.tests

{ t } [ "7F1u3wSD5RbOHQmupo9nx4TnhQ"          boguscoin? ] unit-test
{ t } [ "7iKDZEwPZSqIvDnHvVN2r0hUWXD5rHX"     boguscoin? ] unit-test
{ t } [ "7LOrwbDlS8NujgjddyogWgIM93MV5N2VR"   boguscoin? ] unit-test
{ t } [ "7adNeSwJkMakpEcln9HEtthSRtxdmEHOT8T" boguscoin? ] unit-test

{ f } [ ""        boguscoin? ] unit-test
{ f } [ "foo"     boguscoin? ] unit-test
{ f } [ "7123123" boguscoin? ] unit-test

{ t } [ "7adNeSwJkMakpEcln9HEtthSRtxdmEHOT8T" boguscoin-replace tonys-address = ] unit-test
{ f } [ "7!dNeSwJ?????????9HEtthSRtxdmEHOT8T" boguscoin-replace tonys-address = ] unit-test
{ f } [ ""                                    boguscoin-replace tonys-address = ] unit-test

{ "[Alice] Hey check this out!" } [ "[Alice] Hey check this out!" proxy-rewrite ] unit-test
{ "[Bob] Hello  world! "        } [ "[Bob] Hello  world! "        proxy-rewrite ] unit-test
{ "[Alice] Send me plzzz 7YWHMfk9JZe0LM0g1ZauHuiSxhI" }
[ "[Alice] Send me plzzz 7F1u3wSD5RbOHQmupo9nx4TnhQ"
  proxy-rewrite ] unit-test
