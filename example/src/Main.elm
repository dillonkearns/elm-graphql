module Main exposing (..)

import Api.Object.MenuItem as MenuItem
import Api.Query
import GraphqElm.Field as Field
import GraphqElm.Http
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query
import Html
import RemoteData exposing (WebData)


type Msg
    = GotResponse Model


type alias Model =
    WebData DecodesTo


type alias DecodesTo =
    ( List MenuItem, List String )


type alias MenuItem =
    { id : String
    , name : String
    }


menuItem : Object MenuItem MenuItem.Type
menuItem =
    MenuItem.build MenuItem
        |> Object.with MenuItem.id
        |> Object.with MenuItem.name


menuItemsQuery : Field.Query (List MenuItem)
menuItemsQuery =
    Api.Query.menuItems [] menuItem


makeRequest : Cmd Msg
makeRequest =
    GraphqElm.Query.combine (,) menuItemsQuery Api.Query.captains
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
