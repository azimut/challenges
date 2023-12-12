module RnaTranscription exposing (toRNA)

toRNA : String -> Result String String
toRNA dna =
    dna |> String.foldl (\c -> Result.map2 (++) (charToRNA c)) (Ok "")
        |> Result.map String.reverse

charToRNA : Char -> Result String String
charToRNA c =
    case c of
        'G' -> Ok "C"
        'C' -> Ok "G"
        'T' -> Ok "A"
        'A' -> Ok "U"
        _   -> Err "invalid character"
