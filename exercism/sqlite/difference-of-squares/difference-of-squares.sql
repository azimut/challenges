UPDATE 'difference-of-squares'
   SET result =
       (case property
        when 'squareOfSum'
          then pow(number*(number+1)/2, 2)
        when 'sumOfSquares'
          then number*(number+1)*(2*number+1)/6
        when 'differenceOfSquares'
          then pow(number*(number+1)/2, 2) - number*(number+1)*(2*number+1)/6
        end);
