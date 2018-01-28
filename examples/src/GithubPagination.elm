module GithubPagination exposing (main)

import Github.Object
import Github.Object.Release
import Github.Object.ReleaseConnection
import Github.Object.Repository as Repository
import Github.Object.StargazerConnection
import Github.Object.Topic
import Github.Query as Query
import Github.Scalar
import Graphqelm.Document as Document
import Graphqelm.Field
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { repoInfo : Maybe RepositoryInfo
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
    Query.selection Response
        |> with (Query.repository { owner = "dillonkearns", name = "mobster" } repo)
        |> with (Query.topic { name = "" } topicId)


topicId : SelectionSet Github.Scalar.Id Github.Object.Topic
topicId =
    Github.Object.Topic.selection identity |> with Github.Object.Topic.id


repo : SelectionSet RepositoryInfo Github.Object.Repository
repo =
    Repository.selection RepositoryInfo
        |> with Repository.createdAt
        |> with (Repository.releases (\optionals -> { optionals | first = Present 2 }) releases)
        |> with (Repository.releases (\optionals -> { optionals | last = Present 10 }) releases)
        |> with (Repository.stargazers identity stargazers)


stargazers : SelectionSet Int Github.Object.StargazerConnection
stargazers =
    Github.Object.StargazerConnection.selection identity
        |> with Github.Object.StargazerConnection.totalCount


type alias ReleaseInfo =
    { totalCount : Int
    , releases : Maybe (List (Maybe Release))
    }


releases : SelectionSet ReleaseInfo Github.Object.ReleaseConnection
releases =
    Github.Object.ReleaseConnection.selection ReleaseInfo
        |> with Github.Object.ReleaseConnection.totalCount
        |> with (Github.Object.ReleaseConnection.nodes release)


type alias Release =
    { name : String
    , url : Github.Scalar.Uri
    }


release : SelectionSet Release Github.Object.Release
release =
    Github.Object.Release.selection Release
        |> with (Github.Object.Release.name |> Graphqelm.Field.map (Maybe.withDefault ""))
        |> with Github.Object.Release.url


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.queryRequest "https://api.github.com/graphql"
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
