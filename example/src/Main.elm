module Main exposing (..)

-- import Api.Enum.Weather exposing (Weather)

import Api.Object
import Api.Object.MenuItem as MenuItem
import Api.Query
import Graphqelm.Document as Document exposing (DocumentRoot)
import Graphqelm.Field exposing (FieldDecoder)
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Html
import RemoteData exposing (WebData)
import View.QueryAndResponse


type Msg
    = GotResponse Model


type alias Model =
    WebData Response


type alias Response =
    ( List MenuItem, String )


type alias MenuItem =
    { id : String
    , name : String
    }


menuItem : Object MenuItem Api.Object.MenuItem
menuItem =
    MenuItem.build MenuItem
        |> Object.with MenuItem.id
        |> Object.with MenuItem.name


menuItemsQuery : FieldDecoder (List MenuItem) Document.RootQuery
menuItemsQuery =
    Api.Query.menuItems (\args -> { args | contains = Just "Milkshake" }) menuItem


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "http://localhost:4000/api"
        |> Graphqelm.Http.toRequest
        |> RemoteData.sendRequest
        |> Cmd.map GotResponse


query : Object ( List MenuItem, String ) Document.RootQuery
query =
    Api.Query.build (,)
        |> Object.with menuItemsQuery
        |> Object.with Api.Query.me


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
    View.QueryAndResponse.view query model
