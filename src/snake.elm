module Snake exposing (main)

import Playground exposing (..)


main =
    game view
        update
        { position = 0
        , speed = 1
        , gameOver = False
        }


view computer memory =
    if memory.gameOver == True then
        [ words red "Game Over" ]

    else
        [ square blue 30
            |> moveRight memory.position
        ]


update computer memory =
    if computer.screen.width / 2 == memory.position then
        { memory | gameOver = True }

    else
        { memory
            | position =
                memory.position + memory.speed
        }
