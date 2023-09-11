{ distance = sqrt($1**2 + $2**2) }

distance >  10 { score =  0 }
distance <= 10 { score =  1 }
distance <=  5 { score =  5 }
distance <=  1 { score = 10 }

END { print score }
