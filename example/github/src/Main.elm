module Main exposing (..)

import Api.Object
import Api.Object.Release
import Api.Object.ReleaseConnection
import Api.Object.Repository as Repository
import Api.Object.StargazerConnection
import Api.Query as Query
import Graphqelm exposing (RootQuery)
import Graphqelm.Document as Document
import Graphqelm.Http
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { createdAt : String
    , earlyReleases : ReleaseInfo
    , lateReleases : ReleaseInfo
    , stargazersCount : Int
    }


query : SelectionSet Response RootQuery
query =
    Query.selection identity
        |> with (Query.repository { owner = "dillonkearns", name = "mobster" } repo)


repo : SelectionSet Response Api.Object.Repository
repo =
    Repository.selection Response
        |> with Repository.createdAt
        |> with (Repository.releases (\optionals -> { optionals | first = Present 2 }) releases)
        |> with (Repository.releases (\optionals -> { optionals | last = Present 10 }) releases)
        |> with (Repository.stargazers identity stargazers)


stargazers : SelectionSet Int Api.Object.StargazerConnection
stargazers =
    Api.Object.StargazerConnection.selection identity
        |> with Api.Object.StargazerConnection.totalCount


type alias ReleaseInfo =
    { totalCount : Int
    , releases : List Release
    }


releases : SelectionSet ReleaseInfo Api.Object.ReleaseConnection
releases =
    Api.Object.ReleaseConnection.selection ReleaseInfo
        |> with Api.Object.ReleaseConnection.totalCount
        |> with (Api.Object.ReleaseConnection.nodes release)


type alias Release =
    { name : String
    , url : String
    }


release : SelectionSet Release Api.Object.Release
release =
    Api.Object.Release.selection Release
        |> with Api.Object.Release.name
        |> with Api.Object.Release.url


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "https://api.github.com/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData Graphqelm.Http.Error Response


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
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view model
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
