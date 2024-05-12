#!/usr/bin/jq -Mrf

def sku2product: . as $sku | $products[] | select(.sku == $sku).desc;
def cid2contact: . as $cid | $customers[] | select(.customerid == $cid) | {name,phone};
select((.ordered == .shipped) and (.ordered | contains(" 04:"))) |
  { contact: (.customerid | cid2contact),
    items: (.items | map(.sku) | map(sku2product)) }
