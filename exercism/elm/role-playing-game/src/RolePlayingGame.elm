module RolePlayingGame exposing (Player, castSpell, introduce, revive)

type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }

introduce : Player -> String
introduce { name } =
    Maybe.withDefault "Mighty Magician" name

revive : Player -> Maybe Player
revive player =
    case player.health of
        0 -> if player.level >= 10
             then Just { player | health = 100, mana = Just 100 }
             else Just { player | health = 100, mana = Nothing }
        _ -> Nothing

castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    case player.mana of
        Nothing -> ({player|health = max 0 (player.health - manaCost)}
                   , 0)
        Just mana -> if mana > manaCost
                     then ({player|mana = Just (mana - manaCost)}
                          , manaCost * 2)
                     else (player, 0)
