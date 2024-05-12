CUSTOMERS = data/5784/noahs-customers.jsonl
PRODUCTS  = data/5784/noahs-products.jsonl
ORDERS    = data/5784/noahs-orders.jsonl
SQLITE    = data/5784/noahs.sqlite

.PHONY: all 01 02 03 04 05 06 07
all: 01 02 03 04 05 06 07

01:; ./01.jq < $(CUSTOMERS)
02:; ./02.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)
03:; ./03.jq -n --slurpfile customers $(CUSTOMERS)
04:; ./04.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)
05:; sqlite3 $(SQLITE) < 05.sql
06:; sqlite3 $(SQLITE) < 06.sql
07:; sqlite3 $(SQLITE) < 07.sql


# 5783 = 2023
# 5777 = 2017
data/noahs-jsonl.zip: ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip
data/noahs-csv.zip:   ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-csv.zip
data/noahs-sqlite.zip:; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-sqlite.zip
