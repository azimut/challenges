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
- Read the [docs](https://docs.factorcode.org/content/article-stream-binary.html) about binary streams.
- You can capture tcp traffic data with [Wireshark](https://www.wireshark.org/) to later replay it for a way to test your code offline.

### 03 Budget Chat

A TCP based ascii chatroom. With nicks and message status on join/leave.

Unlike the other ones I did this one offline. No second tries.

Luckly Factor has the necessary primitives for this. I choose [mailboxes](https://docs.factorcode.org/content/vocab-concurrency.mailboxes.html) and [threads](https://docs.factorcode.org/content/vocab-threads.html). There are also channels available but, inlike mailboxes they are 2sides blocking.

### 04 Unusual DB

A UDP based key/value store.

Can't use `<threaded-server>` with UDP. But found an [article](https://re.factorcode.org/2010/04/what-time-is-it-part-2.html) implementing a simple udp server.

Unfortunately Factor seems unable to `receive` empty UDP packets/datagrams. Which are a requirement for this challenge.

## Dev

### Tunnel

External access setup using [pinggy.io](https://pinggy.io/).

- For TCP: `ssh -p 443 -R0:127.0.0.1:1234 qr+tcp@free.pinggy.io`
- For UDP:
  - Tried [pinggy](https://pinggy.io/blog/ngrok_udp_alternative/): `pinggy -p 443 -R0:127.0.0.1:1234 udp@free.pinggy.io`
  - But doesn't seem to work for the edge-case of empty UDP packets. I get an ICMP port unreachable for it.

### Testing

- For TCP/UDP: `nc` or `socat`. I prefer `socat` due being non-interactive.
  - `echo -n "" | nc 127.0.0.1 1234`
  - `echo -n "" | socat - TCP:127.0.0.1:1234`
  - `echo -n "" | socat - UDP:127.0.0.1:1234`

- For UDP: I found `nmap` or `nping` useful to craft custom packets and see it's output.
  - nping: in particular, can show the data sent and received back in one command.
  ```shellsession
  $ sudo nping -v3 --bpf-filter='udp and dst port 53' -c 1 --data-string="foo" --udp -p 1234 127.0.0.1

  Starting Nping 0.7.80 ( https://nmap.org/nping ) at 2025-11-13 14:12 -03
  SENT (0.0107s) UDP [127.0.0.1:53 > 127.0.0.1:1234 len=11 csum=0x275F] IP [ver=4 ihl=5 tos=0x00 iplen=31 id=21414 foff=0 ttl=64 proto=17 csum=0x2926]
  0000   45 00 00 1f 53 a6 00 00  40 11 29 26 7f 00 00 01  E...S...@.)&....
  0010   7f 00 00 01 00 35 04 d2  00 0b 27 5f 66 6f 6f     .....5....'_foo
  RCVD (0.0111s) UDP [127.0.0.1:1234 > 127.0.0.1:53 len=15 csum=0xFE22] IP [ver=4 ihl=5 tos=0x00 iplen=35 id=48370 flg=D foff=0 ttl=64 proto=17 csum=0x7fd5]
  0000   45 00 00 23 bc f2 40 00  40 11 7f d5 7f 00 00 01  E..#..@.@.......
  0010   7f 00 00 01 04 d2 00 35  00 0f fe 22 66 6f 6f 3d  .......5..."foo=
  0020   62 61 72                                          bar

  Max rtt: N/A | Min rtt: N/A | Avg rtt: N/A
  Raw packets sent: 1 (31B) | Rcvd: 1 (35B) | Lost: 0 (0.00%)
  Tx time: 0.00115s | Tx bytes/s: 26979.98 | Tx pkts/s: 870.32
  Rx time: 1.00159s | Rx bytes/s: 34.94 | Rx pkts/s: 1.00
  Nping done: 1 IP address pinged in 1.02 seconds
  ```
