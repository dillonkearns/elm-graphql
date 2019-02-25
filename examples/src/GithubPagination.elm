module GithubPagination exposing (main)

import Browser
import Github.Enum.SearchType
import Github.Object
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
import Graphql.Paginator as Paginator exposing (Paginator)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (button, div, h1, input, p, pre, text)
import Html.Events exposing (onClick)
import PrintAny


type alias Response =
    Paginator Paginator.Forward Repo


query : Int -> Paginator Paginator.Forward Repo -> SelectionSet Response RootQuery
query pageSize paginator =
    Query.searchPaginated pageSize
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


makeRequest : Int -> Paginator Paginator.Forward Repo -> Cmd Msg
makeRequest pageSize paginator =
    query pageSize paginator
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send GotResponse


type Msg
    = GotResponse RemoteDataResponse
    | GetNextPage
    | CountChanged String


type alias Model =
    -- List RemoteDataResponse
    { pageSize : Int
    , data : Paginator Paginator.Forward Repo
    }



-- type PaginatedRemoteData data
--     = NotLoading
--     | Loading data
--     | MoreToLoad data
--     | AllLoaded


type alias RemoteDataResponse =
    Result (Graphql.Http.Error Response) Response


init : Flags -> ( Model, Cmd Msg )
init flags =
    Paginator.forward
        |> (\paginator ->
                ( { pageSize = 1
                  , data = paginator
                  }
                , makeRequest 1 paginator
                )
           )


view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]

            -- , pre [] [ text (Document.serializeQuery (query model.pageSize model.data)) ]
            ]
        , div []
            [ button [ onClick GetNextPage ] [ text <| "Load next " ++ String.fromInt model.pageSize ++ " item(s)..." ]
            , input [ Html.Events.onInput CountChanged ] []
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view (model.data |> Paginator.nodes |> List.reverse)
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetNextPage ->
            ( model, makeRequest model.pageSize model.data )

        GotResponse response ->
            case response of
                Ok successData ->
                    ( { model | data = successData }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        CountChanged newPageSizeString ->
            case newPageSizeString |> String.toInt of
                Just newPageSize ->
                    ( { model | pageSize = newPageSize }, Cmd.none )

                Nothing ->
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
