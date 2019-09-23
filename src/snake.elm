module Snake exposing (main)

import Playground exposing (..)


main =
    game view update 0


view computer offset =
    [ square blue 30
        |> moveRight offset
    ]


update computer offset =
    offset + 1
