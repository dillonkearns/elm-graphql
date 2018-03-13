module Starwars exposing (main)

import Graphqelm.Document as Document
import Graphqelm.Field as Field
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent, Null, Present))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode exposing (Episode)
import Swapi.Enum.Language as Language
import Swapi.InputObject
import Swapi.Interface
import Swapi.Interface.Character as Character
import Swapi.Object
import Swapi.Object.Droid as Droid
import Swapi.Object.Human as Human
import Swapi.Query as Query
import Swapi.Scalar
import Swapi.Union
import Swapi.Union.CharacterUnion as CharacterUnion


type alias Response =
    { vader : HumanLookup
    , tarkin : HumanLookup
    , hero : Character
    , union : Maybe CharacterUnion
    , greeting : String
    }


type HumanOrDroid
    = Human (Maybe String)
    | Droid (Maybe String)


type alias Character =
    { details : Maybe HumanOrDroid
    , name : String
    , id : Swapi.Scalar.Id
    , friends : List String
    , myNum : Int
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
        |> hardcoded 123


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
        |> with (Query.human { id = Swapi.Scalar.Id "1001" } human |> Field.nonNullOrFail)
        |> with (Query.human { id = Swapi.Scalar.Id "1004" } human |> Field.nonNullOrFail)
        |> with
            (Query.hero (\optionals -> { optionals | episode = Present Episode.Empire }) hero)
        |> with
            (Query.heroUnion (\optionals -> { optionals | episode = Present Episode.Empire }) heroUnion)
        |> with
            (Query.greet
                { input = Swapi.InputObject.buildGreeting (\optionals -> { optionals | language = Present Language.Es }) { name = "Chewie" } }
            )


type alias HumanLookup =
    { name : String
    , yearsActive : List Int
    , id : Swapi.Scalar.Id
    , avatarUrl : String
    , homePlanet : Maybe String
    , friends : List Character
    }


human : SelectionSet HumanLookup Swapi.Object.Human
human =
    Human.selection HumanLookup
        |> with Human.name
        |> with (Human.appearsIn |> Field.map (List.map episodeYear))
        |> with Human.id
        |> with Human.avatarUrl
        |> with Human.homePlanet
        |> with (Human.friends hero)


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
        |> Graphqelm.Http.queryRequest "https://graphqelm.herokuapp.com"
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
