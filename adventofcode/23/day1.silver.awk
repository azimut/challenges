BEGIN { FPAT="[0-9]" }
      { sum += int($1 $NF) }
 END  { print sum }
