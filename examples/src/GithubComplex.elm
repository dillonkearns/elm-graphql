module Main exposing (main)

import ElmReposRequest
import Github.Scalar
import Graphqelm.Document as Document
import Graphqelm.Http
import Html exposing (Html, div, h1, img, p, pre, text)
import Html.Attributes exposing (src, style)
import PrintAny
import RemoteData exposing (RemoteData)


makeRequest : Cmd Msg
makeRequest =
    ElmReposRequest.query
        |> Graphqelm.Http.buildQueryRequest "https://api.github.com/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData Graphqelm.Http.Error ElmReposRequest.Response


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
            , pre [] [ text (Document.serializeQuery ElmReposRequest.query) ]
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


successView : ElmReposRequest.Response -> Html.Html msg
successView data =
    div []
        (data.searchResults
            |> List.filterMap identity
            |> List.filterMap identity
            |> List.map resultView
        )


resultView : ElmReposRequest.Repo -> Html.Html msg
resultView result =
    div []
        [ avatarView result.owner.avatarUrl ]


avatarView : Github.Scalar.Uri -> Html msg
avatarView (Github.Scalar.Uri avatarUrl) =
    img [ src avatarUrl, style [ ( "width", "25px" ) ] ] []


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
