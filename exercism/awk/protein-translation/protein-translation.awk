BEGIN {
    FPAT=".{1,3}"
    c2p["AUG"] = "Methionine"
    c2p["UUU"] = c2p["UUC"] = "Phenylalanine"
    c2p["UUA"] = c2p["UUG"] = "Leucine"
    c2p["UCU"] = c2p["UCC"] = c2p["UCA"] = c2p["UCG"] = "Serine"
    c2p["UAU"] = c2p["UAC"] = "Tyrosine"
    c2p["UGU"] = c2p["UGC"] = "Cysteine"
    c2p["UGG"] = "Tryptophan"
    c2p["UAA"] = c2p["UAG"] = c2p["UGA"] = "STOP"
}

{
    for (i = 1; i <= NF; i++) {
        if (!($i in c2p)) invalid_codon()
        if (c2p[$i] == "STOP") break
        result = result (sprintf(latch++?" %s":"%s", c2p[$i]))
    }
    print result
}

function invalid_codon() { printf "Invalid codon"; exit 1; }
