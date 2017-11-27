module Main exposing (..)

import Api.Query
import GraphqElm.Http
import Html
import Http


type Msg
    = GotResponse (Result Http.Error String)


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 123, GraphqElm.Http.request "http://localhost:4000/api" Api.Query.me |> Http.send GotResponse )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            let
                _ =
                    Debug.log "got response" response
            in
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
    Html.text "Hi!!!!"
