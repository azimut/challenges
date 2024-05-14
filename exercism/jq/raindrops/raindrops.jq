def divBy($num;$msg):
  if . % $num == 0 then $msg else "" end;

.number | . as $number
  | divBy(3;"Pling") + divBy(5;"Plang") + divBy(7;"Plong")
  | if . == "" then $number | tostring end
