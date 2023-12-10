module MagicianInTraining exposing (..)
import Array exposing (Array)

getCard : Int -> Array Int -> Maybe Int
getCard = Array.get

setCard : Int -> Int -> Array Int -> Array Int
setCard = Array.set

addCard : Int -> Array Int -> Array Int
addCard = Array.push

removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    deck |> Array.toIndexedList
         |> List.filter (\(i,_) -> i /= index)
         |> List.map Tuple.second
         |> Array.fromList

evenCardCount : Array Int -> Int
evenCardCount deck =
    Array.length <| Array.filter (\n -> modBy 2 n == 0) deck
