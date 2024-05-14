reduce (.strand / "")[] as $char ({A:0,C:0,G:0,T:0}; .[$char] += 1)
  | if keys|add == "ACGT"
    then .
    else "Invalid nucleotide in strand" | halt_error(1)
    end
