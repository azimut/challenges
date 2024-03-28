UPDATE darts
   SET score = iif(sqrt(x*x + y*y) > 10, 0,
                   iif(sqrt(x*x + y*y) > 5, 1,
                       iif(sqrt(x*x + y*y) > 1, 5, 10)));
