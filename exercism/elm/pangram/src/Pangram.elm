module Pangram exposing (isPangram)
import Set

isPangram : String -> Bool
isPangram s =
    s |> String.toLower
      |> String.filter Char.isAlpha
      |> String.toList
      |> Set.fromList
      |> Set.size
      |> ((==) 26)
