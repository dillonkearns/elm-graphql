module Starwars exposing (main)

import CustomScalarCodecs
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
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
import Swapi.Union
import Swapi.Union.CharacterUnion as CharacterUnion


type alias Response =
    { vader : HumanLookup
    , tarkin : HumanLookup
    , hero : Character
    , union : HumanOrDroid
    , greeting : String
    }


type HumanOrDroid
    = Human (Maybe String)
    | Droid (Maybe String)


type alias Character =
    { details : HumanOrDroid
    , name : String
    , id : CustomScalarCodecs.Id
    , friends : List String
    }


hero : SelectionSet Character Swapi.Interface.Character
hero =
    SelectionSet.map4 Character
        (Character.fragments
            { onDroid = SelectionSet.map Droid Droid.primaryFunction
            , onHuman = SelectionSet.map Human Human.homePlanet
            }
        )
        Character.name
        Character.id
        (Character.friends Character.name)


heroUnion : SelectionSet HumanOrDroid Swapi.Union.CharacterUnion
heroUnion =
    CharacterUnion.fragments
        { onDroid = SelectionSet.map Droid Droid.primaryFunction
        , onHuman = SelectionSet.map Human Human.homePlanet
        }


query : SelectionSet Response RootQuery
query =
    SelectionSet.map5 Response
        (Query.human { id = CustomScalarCodecs.Id 1001 } human |> SelectionSet.nonNullOrFail)
        (Query.human { id = CustomScalarCodecs.Id 1004 } human |> SelectionSet.nonNullOrFail)
        (Query.hero (\optionals -> { optionals | episode = Present Episode.Empire }) hero)
        (Query.heroUnion (\optionals -> { optionals | episode = Present Episode.Empire }) heroUnion)
        (Query.greet
            { input = Swapi.InputObject.buildGreeting { name = "Chewie" } (\optionals -> { optionals | language = Present Language.Es }) }
        )


type alias HumanLookup =
    { name : String
    , yearsActive : List Int
    , id : CustomScalarCodecs.Id
    , avatarUrl : String
    , homePlanet : Maybe String
    , friends : List Character
    }


human : SelectionSet HumanLookup Swapi.Object.Human
human =
    SelectionSet.map6 HumanLookup
        Human.name
        (Human.appearsIn |> SelectionSet.map (List.map episodeYear))
        Human.id
        Human.avatarUrl
        Human.homePlanet
        (Human.friends hero)


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
        |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)



-- Elm Architecture Setup


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading, makeRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
