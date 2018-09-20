module View exposing (Data, characterView, view)

import DemoData exposing (DemoData)
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
            [ h1 [ style "margin-top" "30" ] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        ]


type alias Data =
    { name : DemoData String
    , avatarUrl : DemoData String
    , homePlanet : DemoData (Maybe String)
    , friendNames : DemoData (List String)
    }


characterView : Data -> Html msg
characterView characterInfo =
    div [ class "card text-center", style "width" "200", style "margin-right" "20" ]
        [ img
            [ class "card-img-top"
            , characterInfo.avatarUrl |> DemoData.toMaybe |> Maybe.withDefault unkownAvatarUrl |> src
            , style "height" "200"
            , style "width" "200"
            ]
            []
        , div [ class "card-body" ]
            [ h5 [ class "card-title" ] [ characterInfo.name |> DemoData.toMaybe |> Maybe.withDefault "???" |> text ]
            , characterInfo.friendNames |> friendsGroupView
            ]
        ]


homePlanetView : DemoData (Maybe String) -> Html msg
homePlanetView maybeHomePlanet =
    maybeHomePlanet
        |> DemoData.toMaybe
        |> Maybe.map
            (\homePlanet ->
                div []
                    [ div [ class "card-header text-info" ] [ b [] [ text "Home" ] ]
                    , li [ class "list-group-item" ]
                        [ text
                            (homePlanet
                                |> Maybe.withDefault "Unknown"
                            )
                        ]
                    ]
            )
        |> Maybe.withDefault (text "")


unkownAvatarUrl : String
unkownAvatarUrl =
    "/unknown.png"


friendsGroupView : DemoData (List String) -> Html msg
friendsGroupView maybeFriendNames =
    maybeFriendNames
        |> DemoData.toMaybe
        |> Maybe.map
            (\friendNames ->
                div []
                    [ div [ class "card-header text-info" ] [ b [] [ text "Friends" ] ]
                    , ul [ class "list-group" ]
                        (friendNames
                            |> List.map (\name -> li [ class "list-group-item" ] [ text name ])
                        )
                    ]
            )
        |> Maybe.withDefault (text "")
