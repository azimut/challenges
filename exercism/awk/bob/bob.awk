BEGIN { RS = "" } # We get only 1 record, by "here-strings"
{ gsub(/[!,'[:space:]]/, "") } # Makes it easier to check for upper/lower case
   /^[0-9]+$/ { bob = "Whatever."; next } # numbers only...kind of cheating...
/^[A-Z]+[?]$/ { bob = "Calm down, I know what I'm doing!";  next } # YELL Question
    /[?]\s*$/ { bob = "Sure."; next } # Question
  /^[^a-z]+$/ { bob = "Whoa, chill out!"; next } # YELL
          /./ { bob = "Whatever.";  next } # Anything else, but silence
END { print bob ? bob : "Fine. Be that way!" } # Silence
