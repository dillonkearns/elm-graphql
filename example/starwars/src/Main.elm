module Main exposing (..)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object.Character as Character
import Api.Object.Droid as Droid
import Api.Query as Query
import Graphqelm.Field
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)
import View.QueryAndResponse


type alias Response =
    { heroResponse : Hero
    , droidResponse : Droid
    }


query : Graphqelm.Field.Query Response
query =
    Graphqelm.Query.combine Response
        (Query.hero (\args -> { args | episode = Just Episode.EMPIRE }) hero)
        (Query.droid { id = "2000" } droid)


type alias Hero =
    { id : String
    , name : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : Object Hero Character.Type
hero =
    Character.build Hero
        |> Object.with Character.id
        |> Object.with Character.name
        |> Object.with (Character.friends heroWithName)
        |> Object.with Character.appearsIn


heroWithName : Object String Character.Type
heroWithName =
    Character.build identity
        |> Object.with Character.name


type alias Droid =
    { name : String
    , primaryFunction : String
    }


droid : Object.Object Droid Droid.Type
droid =
    Droid.build Droid
        |> Object.with Droid.name
        |> Object.with Droid.primaryFunction


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.request "http://localhost:8080/graphql"
        |> RemoteData.sendRequest
        |> Cmd.map GotResponse


type Msg
    = GotResponse Model


type alias Model =
    WebData Response


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , makeRequest
    )


view : Model -> Html.Html Msg
view model =
    View.QueryAndResponse.view query model


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
