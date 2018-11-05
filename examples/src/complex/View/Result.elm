module View.Result exposing (view)

import Element exposing (Element, text)
import ElmReposRequest
import Github.Scalar
import Html exposing (Html, a, button, div, h1, img, p, pre)
import Html.Attributes exposing (href, src, style, target)


view : ( Bool, ElmReposRequest.Repo ) -> Element msg
view ( hasPackage, result ) =
    Element.row [ Element.width Element.fill ]
        [ Element.row
            [ Element.width (Element.fillPortion 3)
            , Element.spacing 10
            ]
            [ avatarView result.owner.avatarUrl
            , repoLink result.name result.url
            ]
        , Element.row
            [ Element.width (Element.fillPortion 3)
            , Element.spaceEvenly
            ]
            [ text ("⭐️" ++ String.fromInt result.stargazerCount) |> Element.el []
            , text ("🍴" ++ String.fromInt result.forkCount) |> Element.el []
            , packageLink ( hasPackage, result ) |> Element.el []
            , text (dateTimeToString result.timestamps.created)
            ]

        -- , text (" Updated: " ++ dateTimeToString result.timestamps.updated)
        ]


packageLink : ( Bool, ElmReposRequest.Repo ) -> Element msg
packageLink ( hasPackage, result ) =
    if hasPackage then
        Element.newTabLink []
            { url = "http://package.elm-lang.org/packages/" ++ result.name ++ "/latest"
            , label = Element.text "📦"
            }
            |> Element.el [ Element.alignRight ]

    else
        Element.none


dateTimeToString dateTimeString =
    dateTimeString


avatarView : Github.Scalar.Uri -> Element msg
avatarView (Github.Scalar.Uri avatarUrl) =
    Element.image [ Element.width (Element.px 45) ] { src = avatarUrl, description = "Avatar" }


repoLink : String -> Github.Scalar.Uri -> Element msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    Element.newTabLink [] { url = repoUrl, label = text repoName }
