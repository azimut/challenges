#!/usr/bin/jq -Mrf

def cx2phone: .customerid as $cid | $customers[] | select(.customerid == $cid).phone;
def isTargetProduct:
  . as $product
  | $products[]
  | select(.sku == $product).desc
  | ascii_downcase
  | test("coffe|bagel|clean");

# FIXME: exit when found
select(.items | length == 3)
  | select([.items[].sku]
            | all(isTargetProduct))
  | cx2phone
