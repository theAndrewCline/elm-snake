module Snake exposing (main)

import Playground exposing (..)


main =
    game view update { position = 0, speed = 1 }


view computer memory =
    [ square blue 30
        |> moveRight memory.position
    ]


update computer memory =
    { memory
        | position =
            memory.position + memory.speed
    }
