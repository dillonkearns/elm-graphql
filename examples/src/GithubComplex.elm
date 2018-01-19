module Main exposing (main)

import ElmReposRequest
import Github.Scalar
import Graphqelm.Document as Document
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet
import Html exposing (Html, a, div, h1, img, p, pre, text)
import Html.Attributes exposing (href, src, style, target)
import PrintAny
import RemoteData exposing (RemoteData)


makeRequest : ElmReposRequest.SortOrder -> Cmd Msg
makeRequest sortOrder =
    query sortOrder
        |> Graphqelm.Http.buildQueryRequest "https://api.github.com/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse (RemoteData Graphqelm.Http.Error ElmReposRequest.Response)


type alias Model =
    { githubResponse : RemoteData Graphqelm.Http.Error ElmReposRequest.Response
    , sortOrder : ElmReposRequest.SortOrder
    }


init : ( Model, Cmd Msg )
init =
    ( { githubResponse = RemoteData.Loading
      , sortOrder = ElmReposRequest.Stars
      }
    , makeRequest ElmReposRequest.Stars
    )


query : ElmReposRequest.SortOrder -> Graphqelm.SelectionSet.SelectionSet ElmReposRequest.Response RootQuery
query sortOrder =
    ElmReposRequest.query sortOrder


view : Model -> Html.Html Msg
view model =
    div []
        [ elmProjectsView model
        , div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery (query model.sortOrder)) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , PrintAny.view model
            ]
        ]


elmProjectsView : Model -> Html.Html msg
elmProjectsView model =
    case model.githubResponse of
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
        [ avatarView result.owner.avatarUrl
        , repoLink result.name result.url
        , text ("⭐️" ++ toString result.stargazerCount)
        , text ("🍴" ++ toString result.forkCount)
        , text (" Created: " ++ toString result.createdAt)
        , text (" Updated: " ++ toString result.updatedAt)
        ]


avatarView : Github.Scalar.Uri -> Html msg
avatarView (Github.Scalar.Uri avatarUrl) =
    img [ src avatarUrl, style [ ( "width", "35px" ) ] ] []


repoLink : String -> Github.Scalar.Uri -> Html msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    a [ href repoUrl, target "_blank" ] [ text repoName ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( { model | githubResponse = response }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
