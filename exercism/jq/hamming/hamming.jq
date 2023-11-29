(.strand2/"") as $s2pieces |
  if (.strand1|length) == (.strand2|length)
  then (.strand1 / ""
         | to_entries
         | reduce .[] as $kv
                  (0; if $kv.value == $s2pieces[$kv.key]
                      then .
                      else .+1
                      end))
  else "strands must be of equal length" | halt_error
  end
