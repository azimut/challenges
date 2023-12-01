def scans(n):
  if length < n
  then []
  else [(.[0:n]|join(""))] + (.[1:] | scans(n))
  end;

.sliceLength as $len
  | if   .series == ""           then "series cannot be empty"                            |halt_error
    elif $len > (.series|length) then "slice length cannot be greater than series length" |halt_error
    elif $len == 0               then "slice length cannot be zero"                       |halt_error
    elif $len <  0               then "slice length cannot be negative"                   |halt_error
    else (.series / "" | scans($len)) end
