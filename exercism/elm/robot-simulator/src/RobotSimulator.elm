module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )

type Bearing
    = North
    | East
    | South
    | West

type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }

defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }

turnRight : Robot -> Robot
turnRight robot =
    {robot | bearing =
         case robot.bearing of
             North -> East
             East  -> South
             South -> West
             West  -> North
    }

turnLeft : Robot -> Robot
turnLeft robot =
    { robot | bearing =
          case robot.bearing of
              North -> West
              East  -> North
              South -> East
              West  -> South
    }

advance : Robot -> Robot
advance { coordinates, bearing } =
    { bearing = bearing
    , coordinates =
        case bearing of
            North -> { coordinates | y = coordinates.y + 1 }
            South -> { coordinates | y = coordinates.y - 1 }
            East  -> { coordinates | x = coordinates.x + 1 }
            West  -> { coordinates | x = coordinates.x - 1 }
    }

simulate : String -> Robot -> Robot
simulate directions robot =
    String.foldl (\c r -> case c of
                            'L' -> turnLeft r
                            'R' -> turnRight r
                            'A' -> advance r
                            _   -> r)
        robot
        directions
