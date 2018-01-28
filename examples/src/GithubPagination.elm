module GithubPagination exposing (main)

import Github.Enum.SearchType
import Github.Object
import Github.Object.PageInfo
import Github.Object.Repository as Repository
import Github.Object.SearchResultItemConnection
import Github.Object.StargazerConnection
import Github.Query as Query
import Github.Scalar
import Github.Union
import Github.Union.SearchResultItem
import Graphqelm.Document as Document
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument as OptionalArgument exposing (OptionalArgument(Absent, Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (button, div, h1, p, pre, text)
import Html.Events exposing (onClick)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { repos : List (Maybe (Maybe Repo))
    , pageInfo : PageInfo
    }


query : Maybe String -> SelectionSet Response RootQuery
query cursor =
    Query.selection identity
        |> with
            (Query.search
                (\optionals ->
                    { optionals
                        | first = Present 1
                        , after = OptionalArgument.fromMaybe cursor
                    }
                )
                { query = "language:Elm"
                , type_ = Github.Enum.SearchType.Repository
                }
                searchSelection
            )


expectField : Field (Maybe a) typeLock -> Field a typeLock
expectField =
    Field.map expect


expect : Maybe a -> a
expect maybe =
    case maybe of
        Just thing ->
            thing

        Nothing ->
            Debug.crash "Expected to get thing, got nothing"


searchSelection : SelectionSet Response Github.Object.SearchResultItemConnection
searchSelection =
    Github.Object.SearchResultItemConnection.selection Response
        |> with searchResultField
        |> with (Github.Object.SearchResultItemConnection.pageInfo searchPageInfoSelection)


type alias PageInfo =
    { endCursor : Maybe String
    , hasNextPage : Bool
    }


searchPageInfoSelection : SelectionSet PageInfo Github.Object.PageInfo
searchPageInfoSelection =
    Github.Object.PageInfo.selection PageInfo
        |> with Github.Object.PageInfo.endCursor
        |> with Github.Object.PageInfo.hasNextPage


searchResultField : Field.Field (List (Maybe (Maybe Repo))) Github.Object.SearchResultItemConnection
searchResultField =
    Github.Object.SearchResultItemConnection.nodes searchResultSelection |> expectField


searchResultSelection : SelectionSet (Maybe Repo) Github.Union.SearchResultItem
searchResultSelection =
    Github.Union.SearchResultItem.selection identity
        [ Github.Union.SearchResultItem.onRepository repositorySelection ]


type alias Repo =
    { name : String
    , description : Maybe String
    , createdAt : Github.Scalar.DateTime
    , updatedAt : Github.Scalar.DateTime
    , stargazers : Int
    }


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    Repository.selection Repo
        |> with Repository.nameWithOwner
        |> with Repository.description
        |> with Repository.createdAt
        |> with Repository.updatedAt
        |> with (Repository.stargazers identity (Github.Object.StargazerConnection.selection identity |> with Github.Object.StargazerConnection.totalCount))


makeRequest : Maybe String -> Cmd Msg
makeRequest cursor =
    query cursor
        |> Graphqelm.Http.queryRequest "https://api.github.com/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse ModelUnit
    | GetNextPage


type alias Model =
    List ModelUnit


type alias ModelUnit =
    RemoteData Graphqelm.Http.Error Response


init : ( Model, Cmd Msg )
init =
    ( [ RemoteData.Loading ]
    , makeRequest Nothing
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery (query Nothing)) ]
            ]
        , div [] [ button [ onClick GetNextPage ] [ text "Load next page..." ] ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view model
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetNextPage ->
            case model of
                (RemoteData.Success successResponse) :: rest ->
                    if successResponse.pageInfo.hasNextPage then
                        ( RemoteData.Loading :: model, makeRequest successResponse.pageInfo.endCursor )
                    else
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        GotResponse response ->
            case model of
                head :: rest ->
                    ( response :: rest, Cmd.none )

                _ ->
                    ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
