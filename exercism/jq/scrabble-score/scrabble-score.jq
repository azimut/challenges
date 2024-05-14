def rule($value; $letters):
  reduce ($letters/"")[] as $letter
         ({}; .[$letter] = $value);

def rules:
  rule(1;"AEIOULNRST")
      + rule(2;"DG")
      + rule(3;"BCMP")
      + rule(4;"FHVWY")
      + rule(5;"K")
      + rule(8;"JX")
      + rule(10;"QZ");

reduce (.word | ascii_upcase / "")[] as $letter
       (0; . + rules[$letter] // 0)
