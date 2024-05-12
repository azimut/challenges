#!/usr/bin/awk -f
BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
    cid=1;name=2;city=4;phone=6;sku=1;desc=2;oid=1
    while (getline < "data/5784/noahs-products.csv")
        if (index(tolower($desc), "senior cat"))
            catfood[$sku] = 1
    while (getline < "data/5784/noahs-customers.csv")
        if (index(tolower($city), "staten island"))
            islanders[$cid] = $name " " $phone
    while (getline < "data/5784/noahs-orders.csv")
        if ($2 in islanders)
            orders[$oid] = $2
    while (getline < "data/5784/noahs-orders_items.csv")
        if ($1 in orders && $2 in catfood)
            counters[orders[$1]]++
    PROCINFO["sorted_in"] = "@val_num_desc"
    for (customerid in counters) {
        print customerid, counters[customerid], islanders[customerid]
        break
    }
}
