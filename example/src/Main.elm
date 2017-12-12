module Main exposing (..)

import Api.Object
import Api.Object.MenuItem as MenuItem
import Api.Query
import Graphqelm.Document as Document
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.QuerySerializer as QuerySerializer
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)


type Msg
    = GotResponse Model


type alias Model =
    WebData Response


type alias Response =
    ( List MenuItem, String )


query : Object Response Document.RootQuery
query =
    Api.Query.build (,)
        |> Object.with (Api.Query.menuItems (\args -> { args | contains = Just "Milkshake" }) menuItem)
        |> Object.with Api.Query.me


type alias MenuItem =
    { id : String
    , name : String
    }


menuItem : Object MenuItem Api.Object.MenuItem
menuItem =
    MenuItem.build MenuItem
        |> Object.with MenuItem.id
        |> Object.with MenuItem.name


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "http://localhost:4000/api"
        |> Graphqelm.Http.toRequest
        |> RemoteData.sendRequest
        |> Cmd.map GotResponse


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading, makeRequest )


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
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (QuerySerializer.serializeQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]
