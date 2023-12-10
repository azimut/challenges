module Isogram exposing (isIsogram)

isIsogram : String -> Bool
isIsogram sentence =
    sentence |> String.toLower
             |> String.filter Char.isAlpha
             |> String.toList
             |> List.sort
             |> nonRepeated

nonRepeated : List comparable -> Bool
nonRepeated lst =
    case lst of
        x :: y :: xs -> if x < y
                        then nonRepeated (y::xs)
                        else False
        _            -> True
