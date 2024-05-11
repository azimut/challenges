CUSTOMERS = data/5784/noahs-customers.jsonl
PRODUCTS  = data/5784/noahs-products.jsonl
ORDERS    = data/5784/noahs-orders.jsonl

.PHONY: all 01 02
all: 01 02 03

01:; ./01.jq < $(CUSTOMERS)
02:; ./02.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)
03:; ./03.jq -n --slurpfile customers $(CUSTOMERS)
04:; ./04.jq --slurpfile products $(PRODUCTS) --slurpfile customers $(CUSTOMERS) < $(ORDERS)

# 5783 = 2023
# 5777 = 2017
data/noahs-jsonl.zip: ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip
data/noahs-csv.zip:   ; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-csv.zip
data/noahs-sqlite.zip:; wget -P data/ https://hanukkah.bluebird.sh/5784/noahs-sqlite.zip
