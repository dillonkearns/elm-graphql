module Starwars exposing (main)

import Graphqelm.Document as Document
import Graphqelm.FieldDecoder as FieldDecoder
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import Normalize.Enum.Episode_ as Episode exposing (Episode_)
import Normalize.Interface
import Normalize.Interface.Character as Character
import Normalize.Object
import Normalize.Object.Droid as Droid
import Normalize.Object.Human_ as Human
import Normalize.Query as Query
import Normalize.Union
import Normalize.Union.CharacterUnion as CharacterUnion
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { vader : Maybe HumanLookup
    , tarkin : Maybe HumanLookup
    , hero : Character
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


hero : SelectionSet Character Normalize.Interface.Character
hero =
    Character.selection Character
        [ Character.onDroid (Droid.selection Droid |> with Droid.primaryFunction)
        , Character.onHuman_ (Human.selection Human |> with Human.homePlanet)
        ]
        |> with Character.name
        |> with Character.id
        |> with (Character.friends (Character.commonSelection identity |> with Character.name))


type alias CharacterUnion =
    { details : Maybe HumanOrDroid
    }


heroUnion : SelectionSet CharacterUnion Normalize.Union.CharacterUnion
heroUnion =
    CharacterUnion.selection CharacterUnion
        [ CharacterUnion.onDroid (Droid.selection Droid |> with Droid.primaryFunction)
        , CharacterUnion.onHuman_ (Human.selection Human |> with Human.homePlanet)
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


human : SelectionSet HumanLookup Normalize.Object.Human_
human =
    Human.selection HumanLookup
        |> with Human.name
        |> with (Human.appearsIn |> FieldDecoder.map (List.map episodeYear))


episodeYear : Episode_ -> Int
episodeYear episode =
    case episode of
        Episode.Newhope_ ->
            1977

        Episode.Empire ->
            1980

        Episode.Jedi_ ->
            1983


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "http://localhost:4000"
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
