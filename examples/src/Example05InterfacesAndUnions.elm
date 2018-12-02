module Example05InterfacesAndUnions exposing (main)

import Browser
import Graphql.Document as Document
import Graphql.Field as Field
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
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
    Query.selection Response
        |> with (Query.heroUnion identity heroUnionSelection)
        |> with (Query.hero identity heroSelection)
        |> with (Query.heroUnion identity nonExhaustiveFragment)


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
    Swapi.Union.CharacterUnion.selection
        { onHuman = Human.selection HumanDetails |> with Human.homePlanet
        , onDroid = Droid.selection DroidDetails |> with Droid.primaryFunction
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
    Character.selection HumanOrDroidWithName
        |> with Character.name
        |> withFragment heroDetailsFragment


heroDetailsFragment : SelectionSet HumanOrDroidDetails Swapi.Interface.Character
heroDetailsFragment =
    Character.fragments
        { onHuman = Human.selection HumanDetails |> with Human.homePlanet
        , onDroid = Droid.selection DroidDetails |> with Droid.primaryFunction
        }


nonExhaustiveFragment : SelectionSet (Maybe String) Swapi.Union.CharacterUnion
nonExhaustiveFragment =
    let
        maybeFragments =
            Swapi.Union.CharacterUnion.maybeFragments
    in
    Swapi.Union.CharacterUnion.selection
        { maybeFragments
            | onHuman = fieldSelection Human.homePlanet
        }


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com"
        |> Graphql.Http.withCredentials
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


view : Model -> Browser.Document Msg
view model =
    { title = "Starwars Demo"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , pre [] [ text (Document.serializeQuery query) ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , model |> PrintAny.view
                ]
            ]
        ]
    }


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
