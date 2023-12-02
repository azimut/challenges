function max(x,y) { return (x>y)?x:y }
BEGIN { FS="[;:]" }
      { # foreach game
          counts["red"] = counts["green"] = counts["blue"] = 0
          for (i = 2; i <= NF; i++) # foreach set
              for (j = 1; j <= split($i,cubes,","); j++) { # foreach cube
                  split(cubes[j], cube, " ")
                  counts[cube[2]] = max(counts[cube[2]], cube[1])
              }
          power += counts["red"] * counts["green"] * counts["blue"]
      }
  END { print power }
