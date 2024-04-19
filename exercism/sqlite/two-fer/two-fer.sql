UPDATE twofer
   SET response =
       'One for '||iif(input='','you',input)||', one for me.';
