module ExampleFromReadme exposing (main)

import CustomScalarCodecs exposing (Id(..))
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Object
import Swapi.Object.Human as Human
import Swapi.Query as Query


type alias Response =
    Maybe Human


type alias Human =
    { name : String
    , homePlanet : Maybe String
    }


query : SelectionSet (Maybe Human) RootQuery
query =
    Query.human { id = Id 1001 } humanSelection


humanSelection : SelectionSet Human Swapi.Object.Human
humanSelection =
    SelectionSet.map2 Human
        Human.name
        Human.homePlanet


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
