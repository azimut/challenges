module DndCharacter exposing (Character, ability, character, modifier)

import Random exposing (Generator)
import List exposing (sort,drop,sum)

type alias Character =
    { strength : Int
    , dexterity : Int
    , constitution : Int
    , intelligence : Int
    , wisdom : Int
    , charisma : Int
    , hitpoints : Int
    }

modifier : Int -> Int
modifier score = floor <| toFloat (score - 10) / 2

ability : Generator Int
ability =
    Random.int 1 6 |> Random.list 4 |> Random.map (sort >> drop 1 >> sum)

character : Generator Character
character =
    Random.map5 Character ability ability ability ability ability
        |> Random.map2 (|>) ability
        |> Random.map2 (|>) (Random.constant 0) -- hitpoints
        |> Random.map (\c -> { c | hitpoints = (10 + (modifier (.constitution c)))})
