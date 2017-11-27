module Main exposing (..)

import Html


type Msg
    = NoOp


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 123, Cmd.none )


update : a -> b -> ( b, Cmd Msg )
update msg model =
    ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


view : Model -> Html.Html Msg
view model =
    Html.text "Hi!"
