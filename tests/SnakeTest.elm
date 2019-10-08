module SnakeTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, float, int, list, string)
import Snake exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "helper functions"
        [ fuzz2 float float "areCoordsClose should return true or false" <|
            \secondX secondY ->
                if abs (50 - secondX) < 10 && abs (50 - secondY) < 10 then
                    Snake.coordsAreClose 50 50 secondX secondY
                        |> Expect.equal True

                else
                    Snake.coordsAreClose 50 50 secondX secondY
                        |> Expect.equal False
        ]
