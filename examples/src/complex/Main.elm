module Main exposing (main)

import Browser
import Element exposing (Element)
import ElmReposRequest
import Github.Scalar
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet
import Html exposing (Html, a, button, div, h1, img, p, pre, text)
import Html.Attributes exposing (href, src, style, target)
import Html.Events exposing (onClick)
import PrintAny
import RemoteData exposing (RemoteData)
import View.Result


makeRequest : ElmReposRequest.SortOrder -> Cmd Msg
makeRequest sortOrder =
    query sortOrder
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse (RemoteData (Graphql.Http.Error ElmReposRequest.Response) ElmReposRequest.Response)
    | SetSortOrder ElmReposRequest.SortOrder


type alias Model =
    { githubResponse : RemoteData (Graphql.Http.Error ElmReposRequest.Response) ElmReposRequest.Response
    , sortOrder : ElmReposRequest.SortOrder
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { githubResponse = RemoteData.Loading
      , sortOrder = ElmReposRequest.Stars
      }
    , makeRequest ElmReposRequest.Stars
    )


query : ElmReposRequest.SortOrder -> Graphql.SelectionSet.SelectionSet ElmReposRequest.Response RootQuery
query sortOrder =
    ElmReposRequest.query sortOrder


view : Model -> Html Msg
view model =
    Element.layout []
        (div []
            [ sortOrderView model
            , elmProjectsView model
            , div []
                [ h1 [] [ text "Generated Query" ]
                , pre [] [ text (Document.serializeQuery (query model.sortOrder)) ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , PrintAny.view model
                ]
            ]
            |> Element.html
        )


sortOrderView : Model -> Html Msg
sortOrderView model =
    div []
        [ sortButtonView ElmReposRequest.Stars
        , sortButtonView ElmReposRequest.Forks
        , sortButtonView ElmReposRequest.Updated
        ]


sortButtonView : ElmReposRequest.SortOrder -> Html Msg
sortButtonView sortOrder =
    button [ onClick (SetSortOrder sortOrder) ] [ sortOrder |> Debug.toString |> text ]


elmProjectsView : Model -> Html Msg
elmProjectsView model =
    case model.githubResponse of
        RemoteData.Success data ->
            successView data

        _ ->
            div [] []


successView : ElmReposRequest.Response -> Html Msg
successView data =
    div []
        (data.searchResults
            |> List.filterMap identity
            |> List.filterMap identity
            |> List.map View.Result.view
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( { model | githubResponse = response }, Cmd.none )

        SetSortOrder sortOrder ->
            ( { model | sortOrder = sortOrder, githubResponse = RemoteData.Loading }, makeRequest sortOrder )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
