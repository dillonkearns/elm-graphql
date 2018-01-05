module Starwars exposing (main)

import Graphqelm.Document as Document
import Graphqelm.FieldDecoder as FieldDecoder
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode exposing (Episode)
import Swapi.Interface
import Swapi.Interface.Character as Character
import Swapi.Object
import Swapi.Object.Droid as Droid
import Swapi.Object.Human as Human
import Swapi.Query as Query
import Swapi.Union
import Swapi.Union.CharacterUnion as CharacterUnion


type alias Response =
    { vader : Maybe HumanLookup
    , tarkin : Maybe HumanLookup
    , hero : Maybe Character
    , union : Maybe CharacterUnion
    }


type HumanOrDroid
    = Human (Maybe String)
    | Droid (Maybe String)


type alias Character =
    { details : Maybe HumanOrDroid
    , name : String
    , id : String
    , friends : List String
    }


hero : SelectionSet Character Swapi.Interface.Character
hero =
    Character.selection Character
        [ Character.onDroid (Droid.selection Droid |> with Droid.primaryFunction)
        , Character.onHuman (Human.selection Human |> with Human.homePlanet)
        ]
        |> with Character.name
        |> with Character.id
        |> with (Character.friends (Character.commonSelection identity |> with Character.name))


type alias CharacterUnion =
    { details : Maybe HumanOrDroid
    }


heroUnion : SelectionSet CharacterUnion Swapi.Union.CharacterUnion
heroUnion =
    CharacterUnion.selection CharacterUnion
        [ CharacterUnion.onDroid (Droid.selection Droid |> with Droid.primaryFunction)
        , CharacterUnion.onHuman (Human.selection Human |> with Human.homePlanet)
        ]


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.human { id = "1001" } human)
        |> with (Query.human { id = "1004" } human)
        |> with
            (Query.hero (\optionals -> { optionals | episode = Present Episode.Empire }) hero)
        |> with
            (Query.heroUnion (\optionals -> { optionals | episode = Present Episode.Empire }) heroUnion)


type alias HumanLookup =
    { name : String
    , yearsActive : List Int
    }


human : SelectionSet HumanLookup Swapi.Object.Human
human =
    Human.selection HumanLookup
        |> with Human.name
        |> with (Human.appearsIn |> FieldDecoder.map (List.map episodeYear))


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
