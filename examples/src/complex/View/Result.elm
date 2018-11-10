module View.Result exposing (view)

import DateFormat.Relative
import Element exposing (Element, text)
import Element.Font
import ElmReposRequest
import Github.Scalar
import Html exposing (Html, a, button, div, h1, img, p, pre)
import Html.Attributes exposing (href, src, style, target)
import RepoWithOwner exposing (RepoWithOwner)
import Time exposing (Posix)


view : ( Bool, ElmReposRequest.Repo ) -> Element msg
view ( hasPackage, result ) =
    Element.row [ Element.width Element.fill ]
        [ Element.row
            [ Element.width (Element.fillPortion 2)
            , Element.spacing 10
            ]
            [ avatarView result.owner.avatarUrl
            , repoLink result.nameWithOwner result.url
            ]
        , Element.row
            [ Element.width (Element.fillPortion 3)

            -- , Element.spaceEvenly
            ]
            [ text ("⭐️" ++ String.fromInt result.stargazerCount) |> fillWidth 1
            , text ("🍴" ++ String.fromInt result.forkCount) |> fillWidth 1
            , text ("🐞" ++ String.fromInt result.issues) |> fillWidth 1
            , text (dateTimeToString result.timestamps.created) |> fillWidth 2
            , text (dateTimeToString result.timestamps.updated) |> fillWidth 2

            -- , text ("↻ " ++ dateTimeToString result.timestamps.updated)
            , packageLink ( hasPackage, result ) |> Element.el []
            ]
        ]


fillWidth portion =
    Element.el [ Element.width (Element.fillPortion portion) ]


packageLink : ( Bool, ElmReposRequest.Repo ) -> Element msg
packageLink ( hasPackage, result ) =
    if hasPackage then
        Element.newTabLink []
            { url = RepoWithOwner.elmPackageUrl result.nameWithOwner
            , label = Element.text "📦"
            }
            |> Element.el [ Element.alignRight ]

    else
        Element.none


dateTimeToString : Posix -> String
dateTimeToString time =
    let
        now =
            Time.millisToPosix (1541403582 * 1000)
    in
    DateFormat.Relative.relativeTime now time


avatarView : Github.Scalar.Uri -> Element msg
avatarView (Github.Scalar.Uri avatarUrl) =
    Element.image [ Element.width (Element.px 45) ] { src = avatarUrl, description = "Avatar" }


repoLink : RepoWithOwner -> Github.Scalar.Uri -> Element msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    Element.newTabLink []
        { url = repoUrl
        , label =
            repoName
                |> RepoWithOwner.toString
                |> text
                |> Element.el
                    [ Element.Font.color (Element.rgba 0 0 0 0.9)
                    , Element.mouseOver
                        [ Element.Font.color (Element.rgba 0 0 0 0.7)
                        ]
                    ]
        }
