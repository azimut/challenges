module Bob exposing (hey)
import String exposing (endsWith, any)
import Char exposing (isLower, isUpper, isAlpha)

type Remark
    = Question
    | Loud
    | LoudQuestion
    | Silence
    | Other

hey : String -> String
hey phrase =
    phrase |> String.trim
           |> toRemark
           |> response

toRemark : String -> Remark
toRemark s =
    if      endsWith "?" s && allUppercase s     then LoudQuestion
    else if endsWith "?" s                       then Question
    else if any isUpper s && not (any isLower s) then Loud
    else if s == ""                              then Silence
    else Other

allUppercase : String -> Bool
allUppercase s =
    let letters = String.filter isAlpha s in
    letters /= "" && letters == String.filter isUpper s

response : Remark -> String
response remark =
    case remark of
        Question     -> "Sure."
        Loud         -> "Whoa, chill out!"
        LoudQuestion -> "Calm down, I know what I'm doing!"
        Silence      -> "Fine. Be that way!"
        Other        -> "Whatever."
