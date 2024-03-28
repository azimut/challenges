UPDATE raindrops
   SET sound =
       iif(number%3,"","Pling")||
       iif(number%5,"","Plang")||
       iif(number%7,"","Plong");

UPDATE raindrops
   SET sound = number
 WHERE sound = "";
