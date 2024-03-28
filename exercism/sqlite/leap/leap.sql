UPDATE leap
   SET is_leap =
       iif(year%4 = 0,
           iif(year%100 = 0,
               year%400 = 0,
               true),
           false)
