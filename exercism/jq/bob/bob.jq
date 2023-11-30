.heyBob
  | gsub("^\\s+"; "") | gsub("\\s+$"; "") # trim
  | (.|length) as $size
  | gsub("[^a-zA-Z?]";"")
  | if   test("^[A-Z]+$")    then "Whoa, chill out!"
    elif test("^[A-Z]+\\?$") then "Calm down, I know what I'm doing!"
    elif endswith("?")       then "Sure."
    elif $size == 0          then "Fine. Be that way!"
    else                          "Whatever." end
