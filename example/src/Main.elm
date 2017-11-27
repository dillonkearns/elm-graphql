module Main exposing (..)

import Api.Query
import GraphqElm.Http
import Html
import RemoteData exposing (WebData)


type Msg
    = GotResponse Model


type alias Model =
    WebData DecodesTo


type alias DecodesTo =
    List String


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , GraphqElm.Http.request "http://localhost:4000/api" Api.Query.captains
        |> GraphqElm.Http.sendRemoteData GotResponse
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


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
    Html.text (toString model)
