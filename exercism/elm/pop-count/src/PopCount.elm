module PopCount exposing (eggCount)

eggCount : Int -> Int
eggCount n = countOnes n 0

countOnes : Int -> Int -> Int
countOnes n acc =
    case n of
        0 -> acc
        _ -> countOnes (n // 2) (acc + (modBy 2 n))
