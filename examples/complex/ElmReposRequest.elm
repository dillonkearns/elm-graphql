module ElmReposRequest exposing (Repo, SortOrder(..), query, queryForRepos)

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
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Iso8601
import RepoWithOwner exposing (RepoWithOwner)
import Time exposing (Posix)


type alias Repo =
    { nameWithOwner : RepoWithOwner
    , description : Maybe String
    , stargazerCount : Int
    , timestamps : Timestamps
    , forkCount : Int
    , issues : Int
    , owner : Owner
    , url : Github.Scalar.Uri
    }


type SortOrder
    = Forks
    | Stars
    | Updated


query : SortOrder -> SelectionSet (List Repo) RootQuery
query sortOrder =
    Query.search (\optionals -> { optionals | first = Present 100 })
        { query = "language:Elm sort:" ++ (sortOrder |> Debug.toString |> String.toLower)
        , type_ = Github.Enum.SearchType.Repository
        }
        thing


queryForRepos : List RepoWithOwner -> SelectionSet (List Repo) RootQuery
queryForRepos reposWithOwner =
    reposWithOwner
        |> List.map repoWithOwnerSelection
        |> grouped
        |> SelectionSet.map (List.filterMap identity)


grouped :
    List (SelectionSet decodesTo1 scope)
    -> SelectionSet (List decodesTo1) scope
grouped selections =
    List.foldl (SelectionSet.map2 (::))
        (SelectionSet.empty |> SelectionSet.map (\_ -> []))
        selections


repoWithOwnerSelection : RepoWithOwner -> SelectionSet (Maybe Repo) RootQuery
repoWithOwnerSelection repoWithOwner =
    let
        { owner, repoName } =
            RepoWithOwner.ownerAndRepo repoWithOwner
    in
    Query.repository
        { owner = owner, name = repoName }
        repositorySelection


thing : SelectionSet (List Repo) Github.Object.SearchResultItemConnection
thing =
    Github.Object.SearchResultItemConnection.nodes searchResultSelection
        |> SelectionSet.nonNullOrFail
        |> SelectionSet.map (List.filterMap identity)
        |> SelectionSet.map (List.filterMap identity)


searchResultSelection : SelectionSet (Maybe Repo) Github.Union.SearchResultItem
searchResultSelection =
    let
        maybeFragments =
            Github.Union.SearchResultItem.maybeFragments

        partialFragments =
            { maybeFragments
                | onRepository = repositorySelection |> SelectionSet.map Just
            }
    in
    Github.Union.SearchResultItem.fragments partialFragments


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    SelectionSet.succeed Repo
        |> with (Repository.nameWithOwner |> SelectionSet.map RepoWithOwner.repoWithOwner)
        |> with Repository.description
        |> with stargazers
        |> with timestampsSelection
        |> with Repository.forkCount
        |> with openIssues
        |> with (Repository.owner ownerSelection)
        |> with Repository.url


type alias Timestamps =
    { created : Posix
    , updated : Posix
    }


timestampsSelection : SelectionSet Timestamps Github.Object.Repository
timestampsSelection =
    SelectionSet.map2 Timestamps
        (Repository.createdAt |> mapToDateTime)
        (Repository.updatedAt |> mapToDateTime)


mapToDateTime : SelectionSet Github.Scalar.DateTime scope -> SelectionSet Posix scope
mapToDateTime =
    SelectionSet.mapOrFail
        (\(Github.Scalar.DateTime value) ->
            Iso8601.toTime value
                |> Result.mapError (\_ -> "Failed to parse " ++ value ++ " as Iso8601 DateTime.")
        )


stargazers : SelectionSet Int Github.Object.Repository
stargazers =
    Repository.stargazers
        (\optionals -> { optionals | first = Present 0 })
        Github.Object.StargazerConnection.totalCount


openIssues : SelectionSet Int Github.Object.Repository
openIssues =
    Repository.issues
        (\optionals -> { optionals | first = Present 0, states = Present [ Github.Enum.IssueState.Open ] })
        Github.Object.IssueConnection.totalCount


type alias Owner =
    { avatarUrl : Github.Scalar.Uri
    , login : String
    }


ownerSelection : SelectionSet Owner Github.Interface.RepositoryOwner
ownerSelection =
    SelectionSet.map2 Owner
        (Github.Interface.RepositoryOwner.avatarUrl identity)
        Github.Interface.RepositoryOwner.login
