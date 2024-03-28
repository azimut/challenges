UPDATE grains
   SET result =
       iif(task='total',
           pow(2,64)-1,
           pow(2,square-1));
