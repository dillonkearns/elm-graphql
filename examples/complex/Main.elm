module Main exposing (main)

import Browser
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Events
import ElmPackage
import ElmReposRequest
import Graphql.Document as Document
import Graphql.Http
import Html exposing (Html)
import Html.Events exposing (onClick)
import Http
import RemoteData exposing (RemoteData)
import RepoWithOwner
import View.Result


makePackagesGithubQuery : List RepoWithOwner.RepoWithOwner -> Cmd Msg
makePackagesGithubQuery reposWithOwner =
    reposWithOwner
        |> ElmReposRequest.queryForRepos
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send
            (Graphql.Http.parseableErrorAsSuccess
                >> Graphql.Http.withSimpleHttpError
                >> RemoteData.fromResult
                >> GotResponse
            )


type Msg
    = GotResponse (RemoteData (Graphql.Http.RawError () Http.Error) (List ElmReposRequest.Repo))
    | SetSortOrder ElmReposRequest.SortOrder
    | GotElmPackages (RemoteData.WebData (List String))


type alias Model =
    { githubResponse : RemoteData (Graphql.Http.RawError () Http.Error) (List ElmReposRequest.Repo)
    , sortOrder : ElmReposRequest.SortOrder
    , elmPackages : RemoteData.WebData (List String)
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { githubResponse = RemoteData.Loading
      , sortOrder = ElmReposRequest.Stars
      , elmPackages = RemoteData.Loading
      }
    , Cmd.batch
        [ ElmPackage.request
            |> Cmd.map RemoteData.fromResult
            |> Cmd.map GotElmPackages

        -- , makeRequest ElmReposRequest.Stars
        ]
    )


view : Model -> Html Msg
view model =
    Element.layout []
        (Element.column
            [ Element.spacing 30
            , Element.width (Element.fill |> Element.maximum 1200)
            , Element.centerX
            , Element.padding 50
            ]
            [ sortOrderView model
            , elmProjectsView model
            ]
        )


sortOrderView : Model -> Element Msg
sortOrderView model =
    Element.row
        [ Element.spacing 10
        ]
        [ sortButtonView ElmReposRequest.Stars
        , sortButtonView ElmReposRequest.Forks
        , sortButtonView ElmReposRequest.Updated
        ]


sortButtonView : ElmReposRequest.SortOrder -> Element Msg
sortButtonView sortOrder =
    Element.el
        [ Element.Events.onClick (SetSortOrder sortOrder)
        , Element.Border.width 2
        , Element.Border.rounded 5
        , Element.padding 10
        , Element.mouseOver
            [ Element.Background.color (Element.rgba 0 0 0 0.1)
            ]
        , Element.pointer
        ]
        (sortOrder |> Debug.toString |> Element.text)


elmProjectsView : Model -> Element Msg
elmProjectsView model =
    case
        RemoteData.map2
            Tuple.pair
            model.githubResponse
            (model.elmPackages |> RemoteData.mapError Graphql.Http.HttpError)
    of
        RemoteData.Success data ->
            successView data

        RemoteData.Failure error ->
            Element.text ("Error: " ++ Debug.toString error)

        _ ->
            Element.text "Loading..."


successView : ( List ElmReposRequest.Repo, List String ) -> Element Msg
successView ( data, elmPackages ) =
    Element.column [ Element.width Element.fill ]
        ((data
            |> List.map
                (\repo ->
                    ( hasPackage elmPackages repo, repo )
                )
            |> List.filter (\( hasPackageYes, _ ) -> hasPackageYes)
         )
            |> List.map View.Result.view
        )


hasPackage : List String -> ElmReposRequest.Repo -> Bool
hasPackage elmPackages repo =
    elmPackages |> List.any (\package -> RepoWithOwner.toString repo.nameWithOwner == package)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( { model
                | githubResponse =
                    response
                        |> RemoteData.map (List.sortBy .stargazerCount)
                        |> RemoteData.map List.reverse
              }
            , Cmd.none
            )

        SetSortOrder sortOrder ->
            ( { model | sortOrder = sortOrder, githubResponse = RemoteData.Loading }
              -- , makeRequest sortOrder
            , Cmd.none
            )

        GotElmPackages packagesData ->
            case packagesData of
                RemoteData.Success data ->
                    ( { model | elmPackages = packagesData }, makePackagesGithubQuery (data |> List.map RepoWithOwner.repoWithOwner) )

                _ ->
                    ( { model | elmPackages = packagesData }, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
