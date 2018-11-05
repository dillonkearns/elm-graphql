module View.Result exposing (view)

import ElmReposRequest
import Github.Scalar
import Html exposing (Html, a, button, div, h1, img, p, pre, text)
import Html.Attributes exposing (href, src, style, target)


view : ElmReposRequest.Repo -> Html msg
view result =
    div []
        [ avatarView result.owner.avatarUrl
        , repoLink result.name result.url
        , text ("⭐️" ++ String.fromInt result.stargazerCount)
        , text ("🍴" ++ String.fromInt result.forkCount)
        , text (" Created: " ++ dateTimeToString result.timestamps.created)
        , text (" Updated: " ++ dateTimeToString result.timestamps.updated)
        ]


dateTimeToString dateTimeString =
    dateTimeString


avatarView : Github.Scalar.Uri -> Html msg
avatarView (Github.Scalar.Uri avatarUrl) =
    img [ src avatarUrl, style "width" "35px" ] []


repoLink : String -> Github.Scalar.Uri -> Html msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    a [ href repoUrl, target "_blank" ] [ text repoName ]
