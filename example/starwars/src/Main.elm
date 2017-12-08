module Main exposing (..)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object
import Api.Object.Character as Character
import Api.Object.Droid as Droid
import Api.Object.Human as Human
import Api.Query as Query
import Graphqelm.Field
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)
import View.QueryAndResponse


type alias Response =
    -- ( ( Hero, Droid ), Human )
    Human


query : Graphqelm.Field.Query Response
query =
    -- Graphqelm.Query.combine (,)
    --     (Graphqelm.Query.combine (,)
    --         (Query.hero (\args -> { args | episode = Just Episode.EMPIRE }) hero)
    --         (Query.droid { id = "2000" } droid)
    --     )
    --     (Query.human { id = "1004" } human)
    Query.human { id = "1004" } human


type alias Hero =
    { id : String
    , name : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : Object Hero Api.Object.Character
hero =
    Character.build Hero
        |> Object.with Character.id
        |> Object.with Character.name
        |> Object.with (Character.friends heroWithName)
        |> Object.with Character.appearsIn


heroWithName : Object String Api.Object.Character
heroWithName =
    Character.build identity
        |> Object.with Character.id


type alias Droid =
    { name : String
    , primaryFunction : String
    }


droid : Object.Object Droid Api.Object.Droid
droid =
    Droid.build Droid
        |> Object.with Droid.name
        |> Object.with Droid.primaryFunction


type alias Human =
    { name : String
    , appearsIn : List ( Episode, Int )
    }


human : Object.Object Human Api.Object.Human
human =
    Human.build Human
        |> Object.with Human.name
        |> Object.with
            (Human.appearsIn
                |> Graphqelm.Field.map
                    (\episodes ->
                        List.map
                            (\episode -> ( episode, episodeYear episode ))
                            episodes
                    )
            )


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
