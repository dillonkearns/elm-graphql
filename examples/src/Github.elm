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
import Graphql.Field as Field
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet, with)
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
    Query.selection Response
        |> with (Query.repository { owner = "dillonkearns", name = "mobster" } repo |> Field.nonNullOrFail)
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
    , releases : List Release
    }


releases : SelectionSet ReleaseInfo Github.Object.ReleaseConnection
releases =
    Github.Object.ReleaseConnection.selection ReleaseInfo
        |> with Github.Object.ReleaseConnection.totalCount
        |> with (Github.Object.ReleaseConnection.nodes release |> Field.nonNullOrFail |> Field.nonNullElementsOrFail)


type alias Release =
    { name : String
    , url : Github.Scalar.Uri
    }


release : SelectionSet Release Github.Object.Release
release =
    Github.Object.Release.selection Release
        |> with (Github.Object.Release.name |> Field.map (Maybe.withDefault ""))
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


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
