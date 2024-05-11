#!/usr/bin/jq -Mrf

def cx2phone: .customerid as $cid | $customers[] | select(.customerid == $cid).phone;
def isTargetProduct:
  . as $product
  | $products[]
  | select(.sku == $product).desc
  | test("coffe|bagel|clean"; "i");

# FIXME: exit when found
select(.items | length == 3)
  | select([.items[].sku] | all(isTargetProduct))
  | cx2phone
