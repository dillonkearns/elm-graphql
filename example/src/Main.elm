module Main exposing (..)

import Api.Query
import GraphqElm.Http
import GraphqElm.Query
import Html
import RemoteData exposing (WebData)


type Msg
    = GotResponse Model


type alias Model =
    WebData DecodesTo


type alias DecodesTo =
    ( String, List String )


makeRequest : Cmd Msg
makeRequest =
    GraphqElm.Query.combine (,) Api.Query.me Api.Query.captains
        |> GraphqElm.Http.request "http://localhost:4000/api"
        |> GraphqElm.Http.sendRemoteData GotResponse


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , makeRequest
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
