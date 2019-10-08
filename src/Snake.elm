module Snake exposing (..)

import Playground exposing (..)


type alias Food =
    { x : Int
    , y : Int
    }


type alias Memory =
    { positionX : Number
    , positionY : Number
    , speed : Number
    , gameOver : Bool
    , direction : String
    , food : Food
    }


main =
    game view
        update
        { positionX = 0
        , positionY = 0
        , position = 0
        , speed = 1
        , gameOver = False
        , direction = "right"
        , points = 0
        , food =
            { x = 100
            , y = 0
            }
        }


view computer memory =
    if memory.gameOver == True then
        [ words red "Game Over" ]

    else
        [ square blue 30
            |> move memory.positionX memory.positionY
        , square red 30
            |> move memory.food.x memory.food.y
        , words black ("Points: " ++ String.fromInt memory.points)
            |> move -(computer.screen.width / 2 - 40) (computer.screen.height / 2 - 20)
        ]


update computer memory =
    if
        computer.screen.width
            / 2
            == abs memory.positionX
            || computer.screen.height
            / 2
            == abs memory.positionY
    then
        { memory | gameOver = True }

    else if computer.keyboard.up then
        { memory
            | direction = "up"
            , positionY = memory.positionY + memory.speed
        }

    else if computer.keyboard.down then
        { memory
            | direction = "down"
            , positionY = memory.positionY - memory.speed
        }

    else if computer.keyboard.right then
        { memory
            | direction = "right"
            , positionX = memory.positionX + memory.speed
        }

    else if computer.keyboard.left then
        { memory
            | direction = "left"
            , positionX = memory.positionX - memory.speed
        }

    else if coordsAreClose memory.positionX memory.positionY memory.food.x memory.food.y then
        { memory
            | points = memory.points + 10
            , food = { x = -300, y = 300 }
        }

    else if memory.direction == "up" then
        { memory
            | positionY = memory.positionY + memory.speed
        }

    else if memory.direction == "down" then
        { memory
            | positionY = memory.positionY - memory.speed
        }

    else if memory.direction == "right" then
        { memory
            | positionX = memory.positionX + memory.speed
        }

    else if memory.direction == "left" then
        { memory
            | positionX = memory.positionX - memory.speed
        }

    else
        memory


coordsAreClose : Float -> Float -> Float -> Float -> Bool
coordsAreClose x1 y1 x2 y2 =
    if abs (x1 - x2) < 10 && abs (y1 - y2) < 10 then
        True

    else
        False
