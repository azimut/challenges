module TisburyTreasureHunt exposing (..)

type alias PlaceLocation = (Char, Int)
type alias Place = (String, PlaceLocation)
type alias TreasureLocation = (Int, Char)
type alias Treasure = (String, TreasureLocation)

placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation (place, location) = (location, place)

treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLoc treasureLoc =
    (placeLocationToTreasureLocation placeLoc) == treasureLoc

countPlaceTreasures : Place -> List Treasure -> Int
countPlaceTreasures (_, location) treasures =
    treasures |> List.map Tuple.second
              |> List.filter (treasureLocationMatchesPlaceLocation location)
              |> List.length

specialCaseSwapPossible : Treasure -> Place -> Treasure -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case (foundTreasure, place, desiredTreasure) of
        ("Brass Spyglass"     ,"Abandoned Lighthouse"  ,_)                             -> True
        ("Amethyst Octopus"   ,"Stormy Breakwater"     ,"Crystal Crab")                -> True
        ("Amethyst Octopus"   ,"Stormy Breakwater"     ,"Glass Starfish")              -> True
        ("Vintage Pirate Hat" ,"Harbor Managers Office","Model Ship in Large Bottle")  -> True
        ("Vintage Pirate Hat" ,"Harbor Managers Office","Antique Glass Fishnet Float") -> True
        _                                                                              -> False
