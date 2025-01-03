#!/bin/sh
# https://www.upwork.com/jobs/~021874599513349289603
# File too large. Divide into files not exceeding 10MB.

set -e

mkdir -p work/
rm -rf work/*
cd work/

split --verbose -d --sufix-length=4 --line-bytes=$((10 * 1024 * 1024)) "../$1" # assumes file on CWD

# Add headers where missing
for headless in x*; do
    test "${headless}" = "x0000" && continue
    sed -i "1s/^/$(head -n1 x0000)\n/" "${headless}" # assumes header doesn't have "/"
done
