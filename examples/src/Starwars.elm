module Main exposing (main)

import Browser
import Graphql.Document as Document
import Graphql.Field as Field
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (..)
import Html.Attributes exposing (..)
import PrintAny
import RemoteData exposing (RemoteData)
import StarWars.Enum.Episode as Episode exposing (Episode)
import StarWars.InputObject
import StarWars.Interface
import StarWars.Object
import StarWars.Object.Character as Character
import StarWars.Query as Query
import StarWars.Scalar


type alias Response =
    { vader : CharacterInfo
    , all : List CharacterInfo
    }


type alias FriendInfo =
    { name : String
    , id : StarWars.Scalar.Id
    , friends : List String
    }


friendSelection : SelectionSet FriendInfo StarWars.Object.Character
friendSelection =
    Character.selection FriendInfo
        |> with Character.name
        |> with Character.id
        |> with (Character.friends (SelectionSet.fieldSelection Character.name))


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.character { id = StarWars.Scalar.Id "1001" } human |> Field.nonNullOrFail)
        |> with (Query.all human)


type alias CharacterInfo =
    { name : String
    , appearsIn : List String
    , id : StarWars.Scalar.Id
    , avatarUrl : String
    , homePlanet : Maybe String
    , friendNames : List String
    }


human : SelectionSet CharacterInfo StarWars.Object.Character
human =
    Character.selection CharacterInfo
        |> with Character.name
        |> with (Character.appearsIn |> Field.map (List.map episodeNumber))
        |> with Character.id
        |> with Character.avatarUrl
        |> with Character.homePlanet
        |> with (Character.friends (SelectionSet.fieldSelection Character.name))


episodeNumber : Episode -> String
episodeNumber episode =
    case episode of
        Episode.Newhope ->
            "I"

        Episode.Empire ->
            "II"

        Episode.Jedi ->
            "III"


episodeYear : Episode -> Int
episodeYear episode =
    case episode of
        Episode.Newhope ->
            1977

        Episode.Empire ->
            1980

        Episode.Jedi ->
            1983


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "http://localhost:4000"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


init : () -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading
    , makeRequest
    )


mainView : Response -> Html.Html Msg
mainView response =
    div []
        (List.map characterView response.all)


characterView : CharacterInfo -> Html msg
characterView character =
    div [ class "card text-center", style "width" "200", style "margin-right" "20" ]
        [ img
            [ class "card-img-top"
            , src character.avatarUrl
            , style "height" "200"
            , style "width" "200"
            ]
            []
        , div [ class "card-body" ]
            [ h5 [ class "card-title" ] [ text character.name ]
            , div [ class "card-header text-info" ] [ b [] [ text "Home" ] ]
            , li [ class "list-group-item" ] [ text (character.homePlanet |> Maybe.withDefault "Unknown") ]
            , div [ class "card-header text-info" ] [ b [] [ text "Friends" ] ]
            , friendsGroupView character.friendNames
            ]
        ]


friendsGroupView : List String -> Html msg
friendsGroupView friendNames =
    ul [ class "list-group" ]
        (friendNames
            |> List.map (\name -> li [ class "list-group-item" ] [ text name ])
        )


view : Model -> Browser.Document Msg
view model =
    { title = "Starwars Demo"
    , body =
        [ case model of
            RemoteData.Success successData ->
                mainView successData

            RemoteData.Failure error ->
                div [] [ "Error: " ++ Debug.toString error |> text ]

            _ ->
                div [] [ text "Loading..." ]
        , requestResponseView model
        ]
    }


requestResponseView : Model -> Html.Html msg
requestResponseView model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
