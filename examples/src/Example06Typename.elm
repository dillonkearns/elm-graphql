module Example05InterfacesAndUnions exposing (main)

import Browser
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Interface
import Swapi.Interface.Character as Character
import Swapi.Query as Query
import Swapi.Union
import Swapi.Union.CharacterUnion


type alias Response =
    { heroUnion : HumanOrDroid
    , heroInterface : HumanOrDroidWithName
    }


query : SelectionSet Response RootQuery
query =
    SelectionSet.map2 Response
        (Query.heroUnion identity heroUnionSelection)
        (Query.hero identity heroSelection)


type HumanOrDroid
    = Human
    | Droid


heroUnionSelection : SelectionSet HumanOrDroid Swapi.Union.CharacterUnion
heroUnionSelection =
    Swapi.Union.CharacterUnion.fragments
        { onHuman = SelectionSet.succeed Human
        , onDroid = SelectionSet.succeed Droid
        }


type alias HumanOrDroidWithName =
    { name : String
    , details : HumanOrDroid
    }


heroSelection : SelectionSet HumanOrDroidWithName Swapi.Interface.Character
heroSelection =
    SelectionSet.map2 HumanOrDroidWithName
        Character.name
        (Character.fragments
            { onHuman = SelectionSet.succeed Human
            , onDroid = SelectionSet.succeed Droid
            }
        )


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com"
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


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = Helpers.Main.view (Document.serializeQuery query)
        }
