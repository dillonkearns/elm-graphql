module Main exposing (main)

import Github.Enum.IssueState
import Github.Enum.SearchType
import Github.Interface
import Github.Interface.RepositoryOwner
import Github.Object
import Github.Object.IssueConnection
import Github.Object.Repository as Repository
import Github.Object.SearchResultItemConnection
import Github.Object.StargazerConnection
import Github.Query as Query
import Github.Scalar
import Github.Union
import Github.Union.SearchResultItem
import Graphqelm.Document as Document
import Graphqelm.Field as Field
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { searchResults : List (Maybe SearchResult)
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with
            (Query.search (\optionals -> { optionals | first = Present 100 })
                { query = "language:Elm sort:stars", type_ = Github.Enum.SearchType.Repository }
                searchSelection
            )


expectField : Field.Field (Maybe a) typeLock -> Field.Field a typeLock
expectField =
    Field.map expect


expect : Maybe a -> a
expect maybe =
    case maybe of
        Just thing ->
            thing

        Nothing ->
            Debug.crash "Expected to get thing, got nothing"


searchSelection : SelectionSet (List (Maybe SearchResult)) Github.Object.SearchResultItemConnection
searchSelection =
    Github.Object.SearchResultItemConnection.selection identity
        |> with thing


thing : Field.Field (List (Maybe SearchResult)) Github.Object.SearchResultItemConnection
thing =
    Github.Object.SearchResultItemConnection.nodes searchResultSelection |> expectField


maybeWithDefault : a -> Field.Field (Maybe a) typeLock -> Field.Field a typeLock
maybeWithDefault default =
    Field.map (Maybe.withDefault default)


type alias SearchResult =
    { details : Maybe Repo
    }


searchResultSelection : SelectionSet SearchResult Github.Union.SearchResultItem
searchResultSelection =
    Github.Union.SearchResultItem.selection SearchResult
        [ Github.Union.SearchResultItem.onRepository repositorySelection
        ]


type alias Repo =
    { name : String
    , description : Maybe String
    , stargazerCount : Int
    , createdAt : Github.Scalar.DateTime
    , forkCount : Int
    , issues : Int
    , owner : Owner
    }


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    Repository.selection Repo
        |> with Repository.nameWithOwner
        |> with Repository.description
        |> with (Repository.stargazers (\optionals -> { optionals | first = Present 0 }) stargazersCount)
        |> with Repository.createdAt
        |> with Repository.forkCount
        |> with openIssues
        |> with (Repository.owner ownerSelection)


openIssues : Field.Field Int Github.Object.Repository
openIssues =
    Repository.issues (\optionals -> { optionals | first = Present 0, states = Present [ Github.Enum.IssueState.Open ] }) issuesSelection


issuesSelection : SelectionSet Int Github.Object.IssueConnection
issuesSelection =
    Github.Object.IssueConnection.selection identity
        |> with Github.Object.IssueConnection.totalCount


type alias Owner =
    { details : Maybe Never
    , avatarUrl : Github.Scalar.Uri
    }


ownerSelection : SelectionSet Owner Github.Interface.RepositoryOwner
ownerSelection =
    Github.Interface.RepositoryOwner.selection Owner []
        |> with (Github.Interface.RepositoryOwner.avatarUrl identity)


stargazersCount : SelectionSet Int Github.Object.StargazerConnection
stargazersCount =
    Github.Object.StargazerConnection.selection identity
        |> with Github.Object.StargazerConnection.totalCount


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
        [ elmProjectsView model
        , div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view model
            ]
        ]


elmProjectsView : Model -> Html.Html msg
elmProjectsView model =
    case model of
        RemoteData.Success data ->
            successView data

        _ ->
            div [] []


successView : Response -> Html.Html msg
successView data =
    div [] []


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
