def array_add:
  if length == 0
  then 0
  else .[0] + (.[1:] | array_add) end;

def array_reverse:
  if length == 0
  then []
  else (.[1:] | array_reverse) + [first] end;

def array_map(f):
  if length == 0
  then []
  else [first|f] + (.[1:] | array_map(f)) end;
