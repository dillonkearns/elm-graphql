module Main exposing (main)

import Graphqelm exposing (RootQuery)
import Graphqelm.Document as Document
import Graphqelm.FieldDecoder as FieldDecoder
import Graphqelm.Http
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode exposing (Episode)
import Swapi.Object
import Swapi.Object.Character as Character
import Swapi.Object.Droid as Droid
import Swapi.Object.Human as Human
import Swapi.Query as Query


type alias Response =
    { tarkin : Maybe Human
    , vader : Maybe Human
    , hero : HumanOrDroid
    }


type alias WithName =
    { name : String
    , thing : Maybe String
    }


type HumanOrDroid
    = HumanType String (Maybe String)
    | DroidType String


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.human { id = "1004" } human)
        |> with (Query.human { id = "1001" } human)
        -- |> with (Query.hero (\optionals -> { optionals | episode = Present Episode.EMPIRE }) hero)
        |> with (Query.hero (\optionals -> { optionals | episode = Present Episode.EMPIRE }) humanWithName droidWithName)


humanWithName : SelectionSet HumanOrDroid Swapi.Object.Human
humanWithName =
    Human.selection HumanType
        |> with Human.name
        |> with Human.homePlanet


droidWithName : SelectionSet HumanOrDroid Swapi.Object.Droid
droidWithName =
    Droid.selection DroidType
        |> with Droid.name



-- |> with Droid.primaryFunction


type alias Hero =
    { name : String
    , id : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : SelectionSet Hero Swapi.Object.Character
hero =
    Character.selection Hero
        |> with Character.name
        |> with Character.id
        |> with (Character.friends heroWithName)
        |> with Character.appearsIn


heroWithName : SelectionSet String Swapi.Object.Character
heroWithName =
    Character.selection identity
        |> with Character.name


type alias Human =
    { name : String
    , yearsActive : List Int
    }


human : SelectionSet Human Swapi.Object.Human
human =
    Human.selection Human
        |> with Human.name
        |> with (Human.appearsIn |> FieldDecoder.map (List.map episodeYear))


episodeYear : Episode -> Int
episodeYear episode =
    case episode of
        Episode.NEWHOPE ->
            1977

        Episode.EMPIRE ->
            1980

        Episode.JEDI ->
            1983


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "https://graphqelm.herokuapp.com/api"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData Graphqelm.Http.Error Response


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , makeRequest
    )


view : Model -> Html.Html Msg
view model =
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


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
