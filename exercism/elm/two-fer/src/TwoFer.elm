module TwoFer exposing (twoFer)

twoFer : Maybe String -> String
twoFer friend =
    case friend of
        Nothing    -> "One for you, one for me."
        Just name  -> "One for " ++ name ++ ", one for me."
