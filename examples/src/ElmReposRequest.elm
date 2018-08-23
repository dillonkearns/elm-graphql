module ElmReposRequest exposing (Owner, Repo, Response, SortOrder(..), query)

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
import Graphql.Field as Field
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias Response =
    { searchResults : List (Maybe (Maybe Repo))
    }


type SortOrder
    = Forks
    | Stars
    | Updated


query : SortOrder -> SelectionSet Response RootQuery
query sortOrder =
    Query.selection Response
        |> with
            (Query.search (\optionals -> { optionals | first = Present 100 })
                { query = "language:Elm sort:" ++ (sortOrder |> Debug.toString |> String.toLower)
                , type_ = Github.Enum.SearchType.Repository
                }
                searchSelection
            )


expectField : Field.Field (Maybe a) typeLock -> Field.Field a typeLock
expectField =
    Field.map expect


expect : Maybe a -> a
expect maybe =
    case maybe of
        Just thing_ ->
            thing_

        Nothing ->
            Debug.todo "Expected to get thing, got nothing"


searchSelection : SelectionSet (List (Maybe (Maybe Repo))) Github.Object.SearchResultItemConnection
searchSelection =
    Github.Object.SearchResultItemConnection.selection identity
        |> with thing


thing : Field.Field (List (Maybe (Maybe Repo))) Github.Object.SearchResultItemConnection
thing =
    Github.Object.SearchResultItemConnection.nodes searchResultSelection |> expectField


maybeWithDefault : a -> Field.Field (Maybe a) typeLock -> Field.Field a typeLock
maybeWithDefault default =
    Field.map (Maybe.withDefault default)


searchResultSelection : SelectionSet (Maybe Repo) Github.Union.SearchResultItem
searchResultSelection =
    Github.Union.SearchResultItem.selection identity
        [ Github.Union.SearchResultItem.onRepository repositorySelection
        ]


type alias Repo =
    { name : String
    , description : Maybe String
    , stargazerCount : Int
    , createdAt : Github.Scalar.DateTime
    , updatedAt : Github.Scalar.DateTime
    , forkCount : Int
    , issues : Int
    , owner : Owner
    , url : Github.Scalar.Uri
    }


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    Repository.selection Repo
        |> with Repository.nameWithOwner
        |> with Repository.description
        |> with (Repository.stargazers (\optionals -> { optionals | first = Present 0 }) stargazersCount)
        |> with Repository.createdAt
        |> with Repository.updatedAt
        |> with Repository.forkCount
        |> with openIssues
        |> with (Repository.owner ownerSelection)
        |> with Repository.url


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
