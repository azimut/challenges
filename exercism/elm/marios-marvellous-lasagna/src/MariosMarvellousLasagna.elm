module MariosMarvellousLasagna exposing (remainingTimeInMinutes)

remainingTimeInMinutes : Int -> Int -> Int
remainingTimeInMinutes layers cookedTime =
    let
        expectedMinutesInOven = 40
        preparationTimeInMinutes n = n * 2
    in
        preparationTimeInMinutes layers
            + expectedMinutesInOven
            - cookedTime
