def divBy($by): .year % $by == 0;

(divBy(100)|not)
  and divBy(4)
  or divBy(400)
