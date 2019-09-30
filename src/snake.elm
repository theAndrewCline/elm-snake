module Snake exposing (main)

import Playground exposing (..)


type alias Memory =
    { positionX : Number
    , positionY : Number
    , speed : Number
    , gameOver : Bool
    , direction : String
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
        }


view computer memory =
    if memory.gameOver == True then
        [ words red "Game Over" ]

    else
        [ square blue 30
            |> move memory.positionX memory.positionY
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
        { memory | direction = "up" }

    else if computer.keyboard.down then
        { memory | direction = "down" }

    else if computer.keyboard.right then
        { memory | direction = "right" }

    else if computer.keyboard.left then
        { memory | direction = "left" }

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
