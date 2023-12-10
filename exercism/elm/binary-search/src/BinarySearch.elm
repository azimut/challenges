module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Maybe Int
find target xs = binarySearch target 0 xs

binarySearch : Int -> Int -> Array Int -> Maybe Int
binarySearch target currIdx xs =
    let
        len   = Array.length xs
        midx  = len // 2
        left  = Array.slice 0 midx xs
        right = Array.slice (midx+1) len xs
    in
       Maybe.andThen
           (\middle ->
                case compare middle target of
                    EQ -> Just (currIdx+midx)
                    LT -> binarySearch target (currIdx+midx+1) right
                    GT -> binarySearch target (currIdx) left)
           (Array.get midx xs)
