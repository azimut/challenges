BEGIN { FPAT="[[:alnum:]]+('[[:alnum:]]+)?" }

{ for (i = 1; i <= NF; i++)
      words[tolower($i)]++ }

END { for (word in words)
        printf "%s: %d\n", word, words[word] }
