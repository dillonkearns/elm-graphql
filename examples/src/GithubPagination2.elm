module GithubPagination2 exposing (main)

import Browser
import Github.Enum.SearchType
import Github.Object
import Github.Object.PageInfo
import Github.Object.Repository as Repository
import Github.Object.SearchResultItemConnection
import Github.Object.SearchResultItemEdge
import Github.Object.StargazerConnection
import Github.Object.StargazerEdge
import Github.Object.User
import Github.Query as Query
import Github.Scalar
import Github.Union
import Github.Union.SearchResultItem
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.Pagination as Pagination exposing (CurrentPage, Direction(..), PaginatedData)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, button, div, h1, input, p, pre, text)
import Html.Events exposing (onClick)
import PrintAny


type alias Response =
    PaginatedData Stargazer String


query : Int -> PaginatedData Stargazer String -> SelectionSet Response RootQuery
query pageSize paginator =
    let
        setup =
            Forward
    in
    Query.repository { owner = "dillonkearns", name = "elm-graphql" }
        (Repository.stargazersPaginated
            pageSize
            paginator
            identity
            stargazerSelection
        )
        |> SelectionSet.nonNullOrFail


type alias Stargazer =
    { name : String
    , starredAt : Github.Scalar.DateTime
    }


stargazerSelection : SelectionSet (List Stargazer) Github.Object.StargazerConnection
stargazerSelection =
    Github.Object.StargazerConnection.edges
        (SelectionSet.map2 Stargazer
            (Github.Object.StargazerEdge.node (Github.Object.User.name |> SelectionSet.withDefault "???"))
            Github.Object.StargazerEdge.starredAt
        )
        |> SelectionSet.nonNullOrFail
        |> SelectionSet.nonNullElementsOrFail


makeRequest : Int -> PaginatedData Stargazer String -> Cmd Msg
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
    , data : PaginatedData Stargazer String
    }


type alias RemoteDataResponse =
    Result (Graphql.Http.Error Response) Response


init : Flags -> ( Model, Cmd Msg )
init flags =
    Pagination.init Forward []
        |> (\paginator ->
                ( { pageSize = 1
                  , data = paginator
                  }
                , makeRequest 1 paginator
                )
           )


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]

            -- , pre [] [ text (Document.serializeQuery (query model.pageSize model.data)) ]
            ]
        , div []
            [ button [ onClick GetNextPage ] [ text <| "Load next " ++ String.fromInt model.pageSize ++ " item(s)..." ]
            , input [ Html.Events.onInput CountChanged ] []
            , paginationDetailsView model
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view (model.data.data |> List.reverse)
            ]
        ]


paginationDetailsView : Model -> Html msg
paginationDetailsView model =
    doneView model


doneView model =
    Html.text
        (if model.data.currentPage.hasNextPage then
            "Loading..."

         else
            "✅"
        )


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
