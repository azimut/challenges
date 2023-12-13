module SimpleCipher exposing (decode, encode, keyGen)

import List exposing (map)
import Random exposing (Generator)

encode : String -> String -> String
encode key plaintext =
    List.map2 (+) (explode <| repeatBy key plaintext) (explode plaintext)
        |> implode

decode : String -> String -> String
decode key ciphertext =
    List.map2 (-) (explode ciphertext) (explode <| repeatBy key ciphertext)
        |> implode

keyGen : Generator String
keyGen =
    Random.int (Char.toCode 'a') (Char.toCode 'z')
        |> Random.list 100
        |> Random.map (map (\n -> n + Char.toCode 'a'))
        |> Random.map implode

repeatBy : String -> String -> String
repeatBy key input = key |> String.repeat (String.length input)

explode : String -> List Int
explode = String.toList >> map Char.toCode >> map (\n -> n - Char.toCode 'a')

implode : List Int -> String
implode = map (modBy 26) >> map (\n -> n + Char.toCode 'a') >> map Char.fromCode >> String.fromList
