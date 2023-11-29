def phrasify:
  if   length == 0 then []
  elif length == 2 then ["And all for the want of a \(.[1])."]
  else ["For want of a \(.[0]) the \(.[1]) was lost."] + (.[1:]|phrasify) end;

.strings | . + (if first then [first] else [] end) | phrasify
