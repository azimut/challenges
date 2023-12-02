function max(x,y) { return (x>y)?x:y }
BEGIN { FS="[;:]" }
      { # foreach game
          valid = 1
          counts["red"] = counts["green"] = counts["blue"] = 0
          for (i = 2; i <= NF; i++) # foreach set
              for (j = 1; j <= split($i,cubes,","); j++) { # foreach cube
                  split(cubes[j], cube, " ")
                  if (cube[2] == "red"   && cube[1] > 12) valid = 0
                  if (cube[2] == "green" && cube[1] > 13) valid = 0
                  if (cube[2] == "blue"  && cube[1] > 14) valid = 0
                  counts[cube[2]] = max(counts[cube[2]], cube[1])
              }
          power += counts["red"] * counts["green"] * counts["blue"]
          if (valid) sum += NR
      }
  END { print "silver:", sum; print "gold:", power }
