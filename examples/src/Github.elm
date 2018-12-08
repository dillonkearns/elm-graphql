module Github exposing (main)

import Browser
import Github.Object
import Github.Object.Release
import Github.Object.ReleaseConnection
import Github.Object.Repository as Repository
import Github.Object.StargazerConnection
import Github.Object.Topic
import Github.Query as Query
import Github.Scalar exposing (Date)
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Helpers.Main
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { repoInfo : RepositoryInfo
    , topicId : Maybe Github.Scalar.Id
    }


type alias RepositoryInfo =
    { createdAt : Github.Scalar.DateTime
    , earlyReleases : ReleaseInfo
    , lateReleases : ReleaseInfo
    , stargazersCount : Int
    }


query : SelectionSet Response RootQuery
query =
    SelectionSet.succeed Response
        |> with (Query.repository { owner = "dillonkearns", name = "mobster" } repo |> SelectionSet.nonNullOrFail)
        |> with (Query.topic { name = "" } Github.Object.Topic.id)


repo : SelectionSet RepositoryInfo Github.Object.Repository
repo =
    SelectionSet.succeed RepositoryInfo
        |> with Repository.createdAt
        |> with (Repository.releases (\optionals -> { optionals | first = Present 2 }) releases)
        |> with (Repository.releases (\optionals -> { optionals | last = Present 10 }) releases)
        |> with (Repository.stargazers identity Github.Object.StargazerConnection.totalCount)


type alias ReleaseInfo =
    { totalCount : Int
    , releases : List Release
    }


releases : SelectionSet ReleaseInfo Github.Object.ReleaseConnection
releases =
    SelectionSet.succeed ReleaseInfo
        |> with Github.Object.ReleaseConnection.totalCount
        |> with (Github.Object.ReleaseConnection.nodes release |> SelectionSet.nonNullOrFail |> SelectionSet.nonNullElementsOrFail)


type alias Release =
    { name : String
    , url : Github.Scalar.Uri
    }


release : SelectionSet Release Github.Object.Release
release =
    SelectionSet.succeed Release
        |> with (Github.Object.Release.name |> SelectionSet.map (Maybe.withDefault ""))
        |> with Github.Object.Release.url


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


init : () -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading
    , makeRequest
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


type alias Flags =
    ()


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
