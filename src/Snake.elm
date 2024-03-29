module Snake exposing (..)

import Playground exposing (..)


type alias Food =
    { x : Float
    , y : Float
    }


type alias Memory =
    { positionX : Float
    , positionY : Float
    , speed : Float
    , gameOver : Bool
    , direction : String
    , food : Food
    , points : Int
    }


main =
    game view
        update
        { positionX = 0
        , positionY = 0
        , speed = 1
        , gameOver = False
        , direction = "right"
        , points = 0
        , food =
            { x = 100
            , y = 0
            }
        }


view : Computer -> Memory -> List Shape
view computer memory =
    if memory.gameOver == True then
        [ words red "Game Over"
        , words black ("Score: " ++ String.fromInt memory.points)
            |> move 0 -20
        ]

    else
        [ square blue 30
            |> move memory.positionX memory.positionY
        , square red 30
            |> move memory.food.x memory.food.y
        , words black ("Points: " ++ String.fromInt memory.points)
            |> move -(computer.screen.width / 2 - 40) (computer.screen.height / 2 - 20)
        ]


update : Computer -> Memory -> Memory
update computer memory =
    endGame computer memory
        |> handleMovement computer
        |> handleKeyPress computer
        |> speedIncreaseRules computer
        |> consumeFood computer


coordsAreClose : Float -> Float -> Float -> Float -> Bool
coordsAreClose x1 y1 x2 y2 =
    if abs (x1 - x2) < 10 && abs (y1 - y2) < 10 then
        True

    else
        False


handleMovement : Computer -> Memory -> Memory
handleMovement computer memory =
    case memory.direction of
        "up" ->
            { memory
                | positionY = memory.positionY + memory.speed
            }

        "down" ->
            { memory
                | positionY = memory.positionY - memory.speed
            }

        "right" ->
            { memory
                | positionX = memory.positionX + memory.speed
            }

        "left" ->
            { memory
                | positionX = memory.positionX - memory.speed
            }

        default ->
            memory


endGame : Computer -> Memory -> Memory
endGame computer memory =
    if
        computer.screen.width
            / 2
            < abs memory.positionX
            || computer.screen.height
            / 2
            < abs memory.positionY
    then
        { memory | gameOver = True }

    else
        memory


handleKeyPress : Computer -> Memory -> Memory
handleKeyPress computer memory =
    if computer.keyboard.up then
        { memory
            | direction = "up"
        }

    else if computer.keyboard.down then
        { memory
            | direction = "down"
        }

    else if computer.keyboard.right then
        { memory
            | direction = "right"
        }

    else if computer.keyboard.left then
        { memory
            | direction = "left"
        }

    else
        memory


consumeFood : Computer -> Memory -> Memory
consumeFood computer memory =
    if coordsAreClose memory.positionX memory.positionY memory.food.x memory.food.y then
        { memory
            | points = memory.points + 10
            , food =
                { x = cos (spin 0.1 computer.time) * (computer.screen.width / 2)
                , y = cos (spin 0.1 computer.time) * (computer.screen.height / 2)
                }
        }

    else
        memory


speedIncreaseRules : Computer -> Memory -> Memory
speedIncreaseRules computer memory =
    if remainderBy 3 memory.points == 0 && memory.points /= 0 then
        { memory
            | speed = 1 + (toFloat memory.points / 60)
        }

    else
        memory
