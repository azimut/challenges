/[^GCTA]/ { print "Invalid nucleotide detected."; exit 2 }
{
    gsub(/G/, "_") # Temporary value, to avoid cycle
    gsub(/C/, "G")
    gsub(/_/, "C")
    gsub(/A/, "U")
    gsub(/T/, "A")
    print
}
