module ArmstrongNumbers exposing (isArmstrongNumber)

isArmstrongNumber : Int -> Bool
isArmstrongNumber nb =
    let sb = String.fromInt nb in
    sb |> String.toList
       |> List.map (\c -> Char.toCode c - Char.toCode '0')
       |> List.map (\n -> n ^ (String.length sb))
       |> List.sum
       |> ((==) nb)
