# Dia π

## Challenge 1: Basic Fibbonacci

Given an integer n being `0 <= n <= 40`. Return the number in nth fibbonacci number.

eg: given `n=10` return `55`

### Output

``` shell
$ time ./1.dc
Enter desired nth fibonacci number: 40
102334155
./1.dc  317,20s user 0,09s system 99% cpu 5:19,73 total
```

### scratchpad

```
0 1 1 2 3 5 8 13 21 34 55 89

[ 0]  ?  ? =  0
[ 1]  ?  ? =  1
[ 2]  0  1 =  1
[ 3]  1  1 =  2
[ 4]  1  2 =  3
[ 5]  2  3 =  5
[ 6]  3  5 =  8
[ 7]  5  8 = 13
[ 8]  8 13 = 21
[ 9] 13 21 = 34
[10] 21 34 = 55
```
