module Snake exposing (main)

import Playground exposing (..)


main =
    game view
        update
        { position = 0
        , speed = 1
        , gameOver = False
        , direction = "right"
        }


view computer memory =
    if memory.gameOver == True then
        [ words red "Game Over" ]

    else
        [ square blue 30
            |> handleDirection memory.direction memory.position
        ]


handleDirection direction =
    case direction of
        "right" ->
            moveRight

        "left" ->
            moveLeft

        "up" ->
            moveUp

        "down" ->
            moveDown

        _ ->
            moveLeft


update computer memory =
    if computer.screen.width / 2 == memory.position then
        { memory | gameOver = True }

    else if computer.keyboard.up then
        { memory | direction = "up" }

    else if computer.keyboard.down then
        { memory | direction = "down" }

    else if computer.keyboard.right then
        { memory | direction = "right" }

    else if computer.keyboard.left then
        { memory | direction = "left" }

    else
        { memory
            | position =
                memory.position + memory.speed
        }
