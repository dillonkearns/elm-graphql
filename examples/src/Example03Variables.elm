module Example03Variables exposing (main)

import CustomScalarCodecs exposing (Id(..))
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode
import Swapi.Interface.Character as Character
import Swapi.Object.Droid as Droid
import Swapi.Object.Human as Human
import Swapi.Query as Query


type alias Response =
    Maybe Human


type alias Human =
    { name : String
    , homePlanet : Maybe String
    }


query : Id -> SelectionSet Response RootQuery
query id =
    Query.human { id = id } <|
        SelectionSet.map2 Human
            Human.name
            Human.homePlanet


makeRequest : Cmd Msg
makeRequest =
    Id 1001
        |> query
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
        , queryString = Document.serializeQuery (query <| Id 1001)
        }
