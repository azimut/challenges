@include "ord"
BEGIN { RS="[,\n]"; FS="" }
      {
          current = 0
          for (i = 1; i <= NF; i++) {
              current += ord($i)
              current *= 17
              current %= 256
          }
          result += current
      }
  END { print result }
