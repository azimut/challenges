# protohackers

My solutions to the network protocol challenges of [protohackers](https://protohackers.com/).

## Challenges

### 01 Prime Time

A server that talks JSON, accepting multiple requests in json format per connection.

``` shellsession
$ { jo method=isPrime number=3; jo method=isP; jo method=isPrime number=10; } | nc 127.0.0.1 1234
{"method":"isPrime","prime":true}
{"error":"r2r failed!"}
{"method":"isPrime","prime":false}
```

### 02 Means to an End

A per connection, in-memory db, controlled by a custom network binary protocol.

```
Byte:  |   0   |  1     2     3     4  |  5     6     7     8  |
Type:  |  char |         int32 (BE)    |         int32 (BE)    |
Value: |  'I'  |       timestamp       |         price         |
Value: |  'Q'  |        mintime        |        maxtime        |
```

Lessons learned
- You can only `print` byte-arrays on a binary encoded `threaded-server`. Nothing else or it will silently fail.
- Read the [docs](https://docs.factorcode.org/content/article-stream-binary.html).
- You can capture tcp traffic data with [Wireshark](https://www.wireshark.org/) to later replay it for a way to test your code offline.

## Dev

External access tunnels setup using [pinggy.io](https://pinggy.io/).
