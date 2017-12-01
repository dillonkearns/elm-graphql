module Main exposing (..)

import Api.Enum.Episode exposing (Episode)
import Api.Object.Character
import Api.Query
import GraphqElm.Field
import GraphqElm.Http
import GraphqElm.Object
import Html
import RemoteData exposing (WebData)


type Msg
    = GotResponse Model


type alias Model =
    WebData DecodesTo


type alias DecodesTo =
    Hero


type alias Hero =
    { id : String
    , name : String
    , friends : List String
    , appearsIn : List Episode
    }


heroQuery : GraphqElm.Field.Query Hero
heroQuery =
    Api.Query.hero [] hero


hero : GraphqElm.Object.Object Hero Api.Object.Character.Type
hero =
    Api.Object.Character.build Hero
        |> GraphqElm.Object.with Api.Object.Character.id
        |> GraphqElm.Object.with Api.Object.Character.name
        |> GraphqElm.Object.with (Api.Object.Character.friends [] heroWithName)
        |> GraphqElm.Object.with Api.Object.Character.appearsIn


heroWithName : GraphqElm.Object.Object String Api.Object.Character.Type
heroWithName =
    Api.Object.Character.build identity
        |> GraphqElm.Object.with Api.Object.Character.name


makeRequest : Cmd Msg
makeRequest =
    heroQuery
        |> GraphqElm.Http.request "http://localhost:8080/graphql"
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
