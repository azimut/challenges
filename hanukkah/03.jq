#!/usr/bin/jq -Mrf

$customers[] | select(.customerid == 1475) | .citystatezip as $neighborhood
  | $customers[]
  | select(.citystatezip == $neighborhood)
  | select(.birthdate | test("^(1927|1939|1951|1963|1975|1987|1999)")) # Rabbit
  | select(.birthdate | test("(06-([2][2-9]|[3][01])|07-([01][0-9]|[2][012]))")) # Cancer
