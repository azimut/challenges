#!/usr/bin/jq -Mrf

def getPhone:
  . as $customer
  | $customers[]
  | select(.customerid == $customer)
  | .phone
;

def isTargetProduct:
  . as $product
  | $products[]
  | select(.sku == $product)
  | .desc
  | ascii_downcase
  | match("coffe|bagel|clean") // {}
  | has("string")
;

# FIXME: exit when found
select(.items | length == 3)
  | select([.items[].sku]
            | map(isTargetProduct)
            | all)
  | .customerid
  | getPhone
