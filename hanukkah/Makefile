CUSTOMERS = data/5784/noahs-customers.jsonl
PRODUCTS  = data/5784/noahs-products.jsonl
ORDERS    = data/5784/noahs-orders.jsonl
SQLITE    = data/5784/noahs.sqlite

.PHONY: all 1 2 3 4 5 6 7 8
all: 1 2 3 4 5 6 7 8

1:; ./01.jq < $(CUSTOMERS)
2:; ./02.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)
3:; ./03.jq -n --slurpfile customers $(CUSTOMERS)
4:; ./04.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)
5:; sqlite3 $(SQLITE) < 5.sql
6:; sqlite3 $(SQLITE) < 6.sql
7:; sqlite3 $(SQLITE) < 7.sql
8:; sqlite3 $(SQLITE) < 8.sql


# 5783 = 2023
# 5777 = 2017
data/noahs-jsonl.zip: ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip
data/noahs-csv.zip:   ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-csv.zip
data/noahs-sqlite.zip:; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-sqlite.zip
