module Starwars exposing (main)

import Browser
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Helpers.Main
import Regex
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
    , union : HumanOrDroid
    , greeting : String
    }


type HumanOrDroid
    = Human (Maybe String)
    | Droid (Maybe String)


type alias Character =
    { details : HumanOrDroid
    , name : String
    , id : Swapi.Scalar.Id
    , friends : List String
    }


hero : SelectionSet Character Swapi.Interface.Character
hero =
    SelectionSet.succeed Character
        |> with
            (Character.fragments
                { onDroid = SelectionSet.map Droid Droid.primaryFunction
                , onHuman = SelectionSet.map Human Human.homePlanet
                }
            )
        |> with Character.name
        |> with Character.id
        |> with (Character.friends Character.name)


heroUnion : SelectionSet HumanOrDroid Swapi.Union.CharacterUnion
heroUnion =
    CharacterUnion.fragments
        { onDroid = SelectionSet.map Droid Droid.primaryFunction
        , onHuman = SelectionSet.map Human Human.homePlanet
        }


query : SelectionSet Response RootQuery
query =
    SelectionSet.succeed Response
        |> with (Query.human { id = Swapi.Scalar.Id "1001" } human |> SelectionSet.nonNullOrFail)
        |> with (Query.human { id = Swapi.Scalar.Id "1004" } human |> SelectionSet.nonNullOrFail)
        |> with
            (Query.hero (\optionals -> { optionals | episode = Present Episode.Empire }) hero)
        |> with
            (Query.heroUnion (\optionals -> { optionals | episode = Present Episode.Empire }) heroUnion)
        |> with
            (Query.greet
                { input = Swapi.InputObject.buildGreeting { name = "Chewie" } (\optionals -> { optionals | language = Present Language.Es }) }
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
    SelectionSet.succeed HumanLookup
        |> with Human.name
        |> with (Human.appearsIn |> SelectionSet.map (List.map episodeYear))
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
        |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com"
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


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = Helpers.Main.view (Document.serializeQuery query)
        }
