module Main exposing (..)

import Api.Object
import Api.Object.Release
import Api.Object.ReleaseConnection
import Api.Object.Repository as Repository
import Api.Object.StargazerConnection
import Api.Query as Query
import Graphqelm exposing (RootQuery)
import Graphqelm.DocumentSerializer as DocumentSerializer
import Graphqelm.Http
import Graphqelm.Object exposing (Object, with)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)


type alias Response =
    { createdAt : String
    , releases : ReleaseInfo
    , stargazersCount : Int
    }


query : Object Response RootQuery
query =
    Query.selection identity
        |> with (Query.repository { owner = "dillonkearns", name = "mobster" } repo)


repo : Object Response Api.Object.Repository
repo =
    Repository.selection Response
        |> with Repository.createdAt
        |> with (Repository.releases (\optionals -> { optionals | last = Just 10 }) releases)
        |> with (Repository.stargazers identity stargazers)


stargazers : Object Int Api.Object.StargazerConnection
stargazers =
    Api.Object.StargazerConnection.selection identity
        |> with Api.Object.StargazerConnection.totalCount


type alias ReleaseInfo =
    { totalCount : Int
    , releases : List Release
    }


releases : Object ReleaseInfo Api.Object.ReleaseConnection
releases =
    Api.Object.ReleaseConnection.selection ReleaseInfo
        |> with Api.Object.ReleaseConnection.totalCount
        |> with (Api.Object.ReleaseConnection.nodes release)


type alias Release =
    { name : String
    , url : String
    }


release : Object Release Api.Object.Release
release =
    Api.Object.Release.selection Release
        |> with Api.Object.Release.name
        |> with Api.Object.Release.url


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "https://api.github.com/graphql"
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
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (DocumentSerializer.serializeQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]


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
