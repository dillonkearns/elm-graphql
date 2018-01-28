module GithubPagination exposing (main)

import Github.Enum.SearchType
import Github.Object
import Github.Object.Repository as Repository
import Github.Object.SearchResultItemConnection
import Github.Query as Query
import Github.Scalar
import Github.Union
import Github.Union.SearchResultItem
import Graphqelm.Document as Document
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { repos : List (Maybe (Maybe Repo))
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with
            (Query.search (\optionals -> { optionals | first = Present 5 })
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


searchSelection : SelectionSet (List (Maybe (Maybe Repo))) Github.Object.SearchResultItemConnection
searchSelection =
    Github.Object.SearchResultItemConnection.selection identity
        |> with searchResultField


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
    , forkCount : Int
    , url : Github.Scalar.Uri
    }


repositorySelection : SelectionSet Repo Github.Object.Repository
repositorySelection =
    Repository.selection Repo
        |> with Repository.nameWithOwner
        |> with Repository.description
        |> with Repository.createdAt
        |> with Repository.updatedAt
        |> with Repository.forkCount
        |> with Repository.url


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
