END { printf "One for %s, one for me.", NF ? $0 : "you" }
