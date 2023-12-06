module Raindrops exposing (raindrops)

raindrops : Int -> String
raindrops n =
    let
        mod3 = if modBy 3 n == 0 then "Pling" else ""
        mod5 = if modBy 5 n == 0 then "Plang" else ""
        mod7 = if modBy 7 n == 0 then "Plong" else ""
        drops = mod3 ++ mod5 ++ mod7
    in
        if String.isEmpty drops
        then String.fromInt n
        else drops
