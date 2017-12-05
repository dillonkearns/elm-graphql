module Main exposing (..)

import Api.Object
import Api.Object.ReleaseConnection
import Api.Object.Repository as Repository
import Api.Object.StargazerConnection
import Api.Query as Query
import Graphqelm.Field
import Graphqelm.Http
import Graphqelm.Object as Object exposing (Object)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)
import View.QueryAndResponse


type alias Response =
    { createdAt : String
    , releasesCount : Int
    , stargazersCount : Int
    }


query : Graphqelm.Field.Query Response
query =
    Query.repository { owner = "dillonkearns", name = "mobster" } repo


repo : Object Response Api.Object.Repository
repo =
    Repository.build Response
        |> Object.with Repository.createdAt
        |> Object.with (Repository.releases releases)
        |> Object.with (Repository.stargazers stargazers)


releases : Object Int Api.Object.ReleaseConnection
releases =
    Api.Object.ReleaseConnection.build identity
        |> Object.with Api.Object.ReleaseConnection.totalCount


stargazers : Object Int Api.Object.StargazerConnection
stargazers =
    Api.Object.StargazerConnection.build identity
        |> Object.with Api.Object.StargazerConnection.totalCount


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildRequest "https://api.github.com/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
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
