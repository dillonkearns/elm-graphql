module Main exposing (..)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object
import Api.Object.Character as Character
import Api.Object.Human as Human
import Api.Query as Query
import Graphqelm.Document as Document exposing (RootQuery)
import Graphqelm.Field
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)
import View.QueryAndResponse


type alias Response =
    { tarkin : Human
    , vader : Human
    , hero : Hero
    }


query : Object Response Document.RootQuery
query =
    Query.build Response
        |> Object.with (Query.human { id = "1004" } human)
        |> Object.with (Query.human { id = "1001" } human)
        |> Object.with (Query.hero identity hero)


type alias Hero =
    { name : String
    , id : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : Object Hero Api.Object.Character
hero =
    Character.build Hero
        |> Object.with Character.name
        |> Object.with Character.id
        |> Object.with (Character.friends heroWithName)
        |> Object.with Character.appearsIn


heroWithName : Object String Api.Object.Character
heroWithName =
    Character.build identity
        |> Object.with Character.name


type alias Human =
    { name : String
    , yearsActive : List Int
    }


human : Object.Object Human Api.Object.Human
human =
    Human.build Human
        |> Object.with Human.name
        |> Object.with
            (Human.appearsIn |> Graphqelm.Field.map (List.map episodeYear))


episodeYear : Episode -> Int
episodeYear episode =
    case episode of
        Episode.NEWHOPE ->
            1977

        Episode.EMPIRE ->
            1980

        Episode.JEDI ->
            1983


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "http://localhost:8080/graphql"
        |> Graphqelm.Http.toRequest
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
