module View exposing (characterView, view)

import Graphql.Document as Document
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData


view query mainViewFunction model =
    { title = "Starwars Demo"
    , body =
        [ case model of
            RemoteData.Success successData ->
                div [ class "text-center" ] [ mainViewFunction successData ]

            RemoteData.Failure error ->
                div [] [ "Error: " ++ Debug.toString error |> text ]

            _ ->
                div [] [ text "Loading..." ]
        , requestResponseView query model
        ]
    }



-- requestResponseView : Model -> Html.Html msg


requestResponseView query model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        ]


characterView :
    { name : String
    , avatarUrl : String
    , homePlanet : Maybe String
    , friendNames : List String
    }
    -> Html msg
characterView characterInfo =
    div [ class "card text-center", style "width" "200", style "margin-right" "20" ]
        [ img
            [ class "card-img-top"
            , src characterInfo.avatarUrl
            , style "height" "200"
            , style "width" "200"
            ]
            []
        , div [ class "card-body" ]
            [ h5 [ class "card-title" ] [ text characterInfo.name ]
            , div [ class "card-header text-info" ] [ b [] [ text "Home" ] ]
            , li [ class "list-group-item" ] [ text (characterInfo.homePlanet |> Maybe.withDefault "Unknown") ]
            , div [ class "card-header text-info" ] [ b [] [ text "Friends" ] ]
            , friendsGroupView characterInfo.friendNames
            ]
        ]


friendsGroupView : List String -> Html msg
friendsGroupView friendNames =
    ul [ class "list-group" ]
        (friendNames
            |> List.map (\name -> li [ class "list-group-item" ] [ text name ])
        )
