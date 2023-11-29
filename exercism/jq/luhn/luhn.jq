gsub("\\s+";"")
  | (length > 1)
      and test("^\\d+$")
      and (. / ""
            | map(tonumber)
            | reverse
            | to_entries
            | map(if .key%2 == 1
                  then .value * 2 | if . > 9 then . - 9 else . end
                  else .value
                  end)
            | add%10 == 0)
