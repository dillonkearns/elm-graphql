module Example05InterfacesAndUnions exposing (main)

import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode
import Swapi.Interface
import Swapi.Interface.Character as Character
import Swapi.Object.Droid as Droid
import Swapi.Object.Human as Human
import Swapi.Query as Query
import Swapi.Scalar exposing (Id(..))
import Swapi.Union
import Swapi.Union.CharacterUnion


type alias Response =
    { heroUnion : HumanOrDroidDetails
    , heroInterface : HumanOrDroidWithName
    , nonExhaustiveFragment : Maybe String
    }


query : SelectionSet Response RootQuery
query =
    SelectionSet.map3 Response
        (Query.heroUnion identity heroUnionSelection)
        (Query.hero identity heroSelection)
        (Query.heroUnion identity nonExhaustiveFragment)


type HumanOrDroidDetails
    = HumanDetails (Maybe String)
    | DroidDetails (Maybe String)



{-
   GraphQL Union types are just like GraphQL Interfaces, except they don't have
   any common fields. So with our `heroSelection`, we can't select common fields
   like `name`, even though both Humans and Droids have them. With an interface,
   you can define the common fields as well.

   https://graphql.org/learn/schema/#union-types

-}


heroUnionSelection : SelectionSet HumanOrDroidDetails Swapi.Union.CharacterUnion
heroUnionSelection =
    Swapi.Union.CharacterUnion.fragments
        { onHuman = SelectionSet.map HumanDetails Human.homePlanet
        , onDroid = SelectionSet.map DroidDetails Droid.primaryFunction
        }


type alias HumanOrDroidWithName =
    { name : String
    , details : HumanOrDroidDetails
    }



{-
   A GraphQL Interface allows you to select both common fields shared between
   the possible return types (like `name`), and type-specific fields (like
   `primaryFunction` or `homePlanet`).

   https://graphql.org/learn/schema/#interfaces
-}


heroSelection : SelectionSet HumanOrDroidWithName Swapi.Interface.Character
heroSelection =
    SelectionSet.map2 HumanOrDroidWithName
        Character.name
        (Character.fragments
            { onHuman = SelectionSet.map HumanDetails Human.homePlanet
            , onDroid = SelectionSet.map DroidDetails Droid.primaryFunction
            }
        )


nonExhaustiveFragment : SelectionSet (Maybe String) Swapi.Union.CharacterUnion
nonExhaustiveFragment =
    let
        maybeFragments =
            Swapi.Union.CharacterUnion.maybeFragments
    in
    Swapi.Union.CharacterUnion.fragments
        { maybeFragments
            | onHuman = Human.homePlanet
        }


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com"
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


type alias Flags =
    ()


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
