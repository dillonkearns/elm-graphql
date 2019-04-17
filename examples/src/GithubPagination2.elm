module GithubPagination2 exposing (main)

import Browser
import Github.Enum.SearchType
import Github.Object
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
import Graphql.Paginator as Paginator exposing (Paginator)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, button, div, h1, input, p, pre, text)
import Html.Events exposing (onClick)
import PrintAny


type alias Response =
    ( Int, Paginator Paginator.Forward Stargazer )



-- queryNew : Int -> Paginator Paginator.Forward Stargazer -> SelectionSet Response RootQuery


query :
    Int
    -> Paginator Paginator.Forward Stargazer
    -> SelectionSet ( Int, Paginator Paginator.Forward Stargazer ) RootQuery
query pageSize paginator =
    Query.repository { owner = "dillonkearns", name = "elm-graphql" }
        (Repository.stargazers3
            pageSize
            paginator
            identity
            (SelectionSet.map2 Tuple.pair
                Github.Object.StargazerConnection.totalCount
                (connectionSelection paginator)
            )
        )
        |> SelectionSet.nonNullOrFail



-- queryOld : Int -> Paginator Paginator.Forward Stargazer -> SelectionSet Response RootQuery
-- queryOld pageSize paginator =
--     Query.repository { owner = "dillonkearns", name = "elm-graphql" }
--         (Repository.stargazersPaginated
--             pageSize
--             paginator
--             identity
--             stargazerSelection
--         )
--         |> SelectionSet.nonNullOrFail


type alias Stargazer =
    { login : String
    , starredAt : Github.Scalar.DateTime
    }


connectionSelection :
    Paginator Paginator.Forward Stargazer
    -> SelectionSet (Paginator Paginator.Forward Stargazer) Github.Object.StargazerConnection
connectionSelection paginator =
    Github.Object.StargazerConnection.edgesPaginator paginator stargazerSelection


stargazerSelection : SelectionSet Stargazer Github.Object.StargazerEdge
stargazerSelection =
    SelectionSet.map2 Stargazer
        -- you can grab core data from the Node like this
        (Github.Object.StargazerEdge.node Github.Object.User.login)
        -- plus you can grab meta-data from the "Edge" (represents the relationship)
        Github.Object.StargazerEdge.starredAt


makeRequest : Int -> Paginator Paginator.Forward Stargazer -> Cmd Msg
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
    { pageSize : Int
    , paginator : Paginator Paginator.Forward Stargazer
    , totalCount : Int
    }


type alias RemoteDataResponse =
    Result (Graphql.Http.Error Response) Response


initialPageSize =
    1


init : Flags -> ( Model, Cmd Msg )
init flags =
    Paginator.forward
        |> (\paginator ->
                ( { pageSize = initialPageSize
                  , paginator = paginator
                  , totalCount = -1
                  }
                , makeRequest initialPageSize paginator
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
            [ p [] [ text <| String.fromInt model.totalCount ]
            , button [ onClick GetNextPage ] [ text <| "Load next " ++ String.fromInt model.pageSize ++ " item(s)..." ]
            , input [ Html.Events.onInput CountChanged ] []
            , paginationDetailsView model
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view (model.paginator |> Paginator.nodes)
            ]
        ]


paginationDetailsView : Model -> Html msg
paginationDetailsView model =
    div []
        [ "Loaded "
            ++ (model.paginator
                    |> Paginator.nodes
                    |> List.length
                    |> String.fromInt
               )
            ++ " so far"
            |> text
        , doneView model
        ]


doneView model =
    Html.text
        (if model.paginator |> Paginator.moreToLoad then
            "..."

         else
            " ✅"
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetNextPage ->
            ( model, makeRequest model.pageSize model.paginator )

        GotResponse response ->
            case response of
                Ok ( totalCount, successData ) ->
                    ( { model | totalCount = totalCount, paginator = successData }, Cmd.none )

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
