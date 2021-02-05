module MobsterQuery exposing (main)

import Github.Object
import Github.Object.Release
import Github.Object.ReleaseAsset
import Github.Object.ReleaseAssetConnection
import Github.Object.ReleaseAssetEdge
import Github.Object.ReleaseConnection
import Github.Object.Repository as Repository
import Github.Object.StargazerConnection
import Github.Query as Query
import Github.Scalar
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)


type alias Response =
    RepositoryInfo


type alias RepositoryInfo =
    { lastRelease : List Release
    , stargazersCount : Int
    }


query : SelectionSet Response RootQuery
query =
    Query.repository { owner = "dillonkearns", name = "mobster" } repo |> SelectionSet.nonNullOrFail


repo : SelectionSet RepositoryInfo Github.Object.Repository
repo =
    SelectionSet.map2 RepositoryInfo
        (Repository.releases (\optionals -> { optionals | last = Present 1 }) releases)
        (Repository.stargazers identity Github.Object.StargazerConnection.totalCount)


releases : SelectionSet (List Release) Github.Object.ReleaseConnection
releases =
    Github.Object.ReleaseConnection.nodes release
        |> SelectionSet.nonNullOrFail
        |> SelectionSet.nonNullElementsOrFail
        |> SelectionSet.map List.head
        |> SelectionSet.nonNullOrFail


type alias Release =
    { url : Github.Scalar.Uri
    , name : String
    , downloadCount : Int
    }


release : SelectionSet (List Release) Github.Object.Release
release =
    Github.Object.Release.releaseAssets (\optionals -> { optionals | last = Present 30 })
        (Github.Object.ReleaseAssetConnection.edges
            (Github.Object.ReleaseAssetEdge.node releaseAssetSelection
                |> SelectionSet.nonNullOrFail
            )
        )
        |> SelectionSet.nonNullOrFail
        |> SelectionSet.nonNullElementsOrFail


releaseAssetSelection : SelectionSet Release Github.Object.ReleaseAsset
releaseAssetSelection =
    SelectionSet.map3 Release
        Github.Object.ReleaseAsset.downloadUrl
        Github.Object.ReleaseAsset.name
        Github.Object.ReleaseAsset.downloadCount


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
