module View.Result exposing (view)

import Element exposing (Element, text)
import ElmReposRequest
import Github.Scalar
import Html exposing (Html, a, button, div, h1, img, p, pre)
import Html.Attributes exposing (href, src, style, target)


view : ( Bool, ElmReposRequest.Repo ) -> Element msg
view ( hasPackage, result ) =
    Element.row []
        [ avatarView result.owner.avatarUrl
        , repoLink result.name result.url
        , text ("⭐️" ++ String.fromInt result.stargazerCount)
        , text ("🍴" ++ String.fromInt result.forkCount)
        , text (" Created: " ++ dateTimeToString result.timestamps.created)
        , text (" Updated: " ++ dateTimeToString result.timestamps.updated)
        , packageLink ( hasPackage, result )
        ]


packageLink : ( Bool, ElmReposRequest.Repo ) -> Element msg
packageLink ( hasPackage, result ) =
    if hasPackage then
        Element.newTabLink []
            { url = "http://package.elm-lang.org/packages/" ++ result.name ++ "/latest"
            , label = Element.text "📦"
            }

    else
        Element.none


dateTimeToString dateTimeString =
    dateTimeString


avatarView : Github.Scalar.Uri -> Element msg
avatarView (Github.Scalar.Uri avatarUrl) =
    Element.image [ Element.width (Element.px 35) ] { src = avatarUrl, description = "Avatar" }


repoLink : String -> Github.Scalar.Uri -> Element msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    Element.newTabLink [] { url = repoUrl, label = text repoName }
