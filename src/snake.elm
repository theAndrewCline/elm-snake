module Main exposing (Model, init, main, subscriptions, update, view)

import Browser
import Html exposing (..)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { statusText : String
    }


init : () -> ( Model, Cmd msg )
init _ =
    ( { statusText = "okay"
      }
    , Cmd.none
    )


type Msg
    = NoOp
    | UpdateText String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateText string ->
            ( { model | statusText = string }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div [] [ text model.statusText ]
