module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import Char exposing (isDigit, toCode)

clean1 : String -> String
clean1 = String.replace " " "_"

clean2 : String -> String
clean2 str =
    ["\n","\t","\r"] |> List.foldl (\ctrl -> String.replace ctrl "[CTRL]") str
                     |> clean1

clean3 : String -> String
clean3 str =
    let capitalize s =
            (String.map Char.toUpper <| String.left 1 s) ++ (String.dropLeft 1 s)
    in str |> String.split "-"
           |> List.indexedMap (\i s -> if i == 0 then s else capitalize s)
           |> String.concat
           |> clean2

clean4 : String -> String
clean4 str =
    str |> String.filter (isDigit >> not)
        |> clean3

clean : String -> String
clean str =
    let isGreek c = (c >= 'α') && (c <= 'ω') in
    str |> String.filter (isGreek >> not)
        |> clean4
