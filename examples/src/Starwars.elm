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


type alias Character =
    { name : String
    , id : StarWars.Scalar.Id
    , friends : List String
    }


hero : SelectionSet Character StarWars.Object.Character
hero =
    Character.selection Character
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
    , yearsActive : List Int
    , id : StarWars.Scalar.Id
    , avatarUrl : String
    , homePlanet : Maybe String
    , friends : List Character
    }


human : SelectionSet CharacterInfo StarWars.Object.Character
human =
    Character.selection CharacterInfo
        |> with Character.name
        |> with (Character.appearsIn |> Field.map (List.map episodeYear))
        |> with Character.id
        |> with Character.avatarUrl
        |> with Character.homePlanet
        |> with (Character.friends hero)


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
    div [ class "card no-gutters", style "width" "200" ]
        [ img
            [ class "card-img-top"
            , src character.avatarUrl
            , style "height" "200"
            ]
            []
        , div [ class "card-body" ]
            [ h5 [ class "card-title text-center" ] [ text character.name ]
            ]
        ]


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
        , div []
            [ h1 [] [ text "Response" ]
            , model |> PrintAny.view
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
