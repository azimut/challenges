(ns protein-translation)

(defn translate-codon [codon]
  (case codon
    "AUG" "Methionine"
    "UGG" "Tryptophan"
    ("UUU" "UUC") "Phenylalanine"
    ("UUA" "UUG") "Leucine"
    ("UAU" "UAC") "Tyrosine"
    ("UGU" "UGC") "Cysteine"
    ("UCU" "UCC" "UCA" "UCG") "Serine"
    ("UAA" "UAG" "UGA") "STOP"))

(defn translate-rna [rna]
  (->> (partition 3 rna)
       (map #(apply str %))
       (map translate-codon)
       (take-while #(not= "STOP" %))))
