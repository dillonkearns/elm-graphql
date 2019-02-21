module GithubPagination exposing (main)

import Browser
import Github.Enum.SearchType
import Github.Object
import Github.Object.PageInfo
import Github.Object.Repository as Repository
import Github.Object.SearchResultItemConnection
import Github.Object.SearchResultItemEdge
import Github.Object.StargazerConnection
import Github.Query as Query
import Github.Scalar
import Github.Union
import Github.Union.SearchResultItem
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.PaginatorSetup as PaginatorSetup exposing (CurrentPage, Direction(..), PaginatedData)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (button, div, h1, p, pre, text)
import Html.Events exposing (onClick)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    PaginatedData Repo String



-- first query -> No Cursor, just count (first or last)
-- Result comes back -> Get a cursor, maintain the count
-- second query, Cursor, no count (use from previous)


query : PaginatedData any String -> SelectionSet Response RootQuery
query paginator =
    let
        setup =
            Forward
    in
    Query.searchPaginated 1
        paginator
        identity
        { query = "language:Elm", type_ = Github.Enum.SearchType.Repository }
        searchResultFieldEdges


searchResultFieldEdges : SelectionSet (List Repo) Github.Object.SearchResultItemConnection
searchResultFieldEdges =
    Github.Object.SearchResultItemConnection.edges
        (Github.Object.SearchResultItemEdge.node searchResultSelection
            |> SelectionSet.nonNullOrFail
        )
        |> SelectionSet.nonNullOrFail
        |> SelectionSet.nonNullElementsOrFail
        |> SelectionSet.nonNullElementsOrFail


searchResultSelection : SelectionSet (Maybe Repo) Github.Union.SearchResultItem
searchResultSelection =
    let
        defaults =
            Github.Union.SearchResultItem.maybeFragments
    in
    Github.Union.SearchResultItem.fragments
        { defaults | onRepository = repositorySelection |> SelectionSet.map Just }


type alias Repo =
    { name : String
    , description : Maybe String
    , createdAt : Github.Scalar.DateTime
    , updatedAt : Github.Scalar.DateTime
    , stargazers : Int
    }


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    SelectionSet.succeed Repo
        |> with Repository.nameWithOwner
        |> with Repository.description
        |> with Repository.createdAt
        |> with Repository.updatedAt
        |> with (Repository.stargazers identity Github.Object.StargazerConnection.totalCount)


makeRequest : PaginatedData any String -> Cmd Msg
makeRequest paginator =
    query paginator
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (\result -> result |> RemoteData.fromResult |> GotResponse)


type Msg
    = GotResponse RemoteDataResponse
    | GetNextPage


type alias Model =
    -- List RemoteDataResponse
    PaginatedData RemoteDataResponse String



-- type PaginatedRemoteData data
--     = NotLoading
--     | Loading data
--     | MoreToLoad data
--     | AllLoaded


type alias RemoteDataResponse =
    RemoteData (Graphql.Http.Error Response) Response


init : Flags -> ( Model, Cmd Msg )
init flags =
    PaginatorSetup.init Forward [ RemoteData.Loading ]
        |> (\paginator -> ( paginator, makeRequest paginator ))


view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery (query model)) ]
            ]
        , div [] [ button [ onClick GetNextPage ] [ text "Load next page..." ] ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view (model.data |> List.reverse)
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetNextPage ->
            case model.data of
                (RemoteData.Success successResponse) :: rest ->
                    if successResponse.currentPage.done then
                        ( { model | data = RemoteData.Loading :: model.data }, makeRequest successResponse )

                    else
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        GotResponse response ->
            case model.data of
                head :: rest ->
                    ( { model | data = response :: rest }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
