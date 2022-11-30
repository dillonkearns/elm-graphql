module ErrorHandling exposing (main)

import CustomScalarCodecs
import Graphql.Document as Document
import Graphql.Http
import Graphql.Http.GraphqlError
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Object
import Swapi.Object.Human as Human
import Swapi.Query as Query


type alias Response =
    { vader : Human

    -- uncomment lines 21 and 30 to see an unrecoverable error
    -- , unrecoverableError : String
    , forcedError : Maybe String
    }


query : SelectionSet Response RootQuery
query =
    SelectionSet.succeed Response
        |> with (Query.human { id = CustomScalarCodecs.Id 1001 } human |> SelectionSet.nonNullOrFail)
        -- |> with (Query.forcedError |> SelectionSet.nonNullOrFail)
        |> with Query.forcedError


type alias Human =
    { name : String }


human : SelectionSet Human Swapi.Object.Human
human =
    SelectionSet.succeed Human
        |> with Human.name


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com"
        |> Graphql.Http.send (RemoteData.fromResult >> responseDetails >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    String


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( ""
    , makeRequest
    )


responseDetails : RemoteData (Graphql.Http.Error Response) Response -> String
responseDetails model =
    case model of
        RemoteData.Failure error ->
            case error of
                Graphql.Http.GraphqlError possiblyParsedData errors ->
                    "GraphQL errors: \n"
                        ++ Debug.toString errors
                        ++ "\n\n"
                        ++ (case possiblyParsedData of
                                Graphql.Http.GraphqlError.UnparsedData unparsed ->
                                    "Unable to parse data, got: " ++ Debug.toString unparsed

                                Graphql.Http.GraphqlError.ParsedData parsedData ->
                                    "Parsed error data, so I can extract the name from the structured data... parsedData.vader.name = " ++ parsedData.vader.name
                           )

                Graphql.Http.HttpError httpError ->
                    "Http error " ++ Debug.toString httpError

        RemoteData.Loading ->
            "Loading"

        RemoteData.NotAsked ->
            "Not Asked"

        RemoteData.Success successData ->
            "Request succeeded so I can use the structured data here... successData.vader.name = " ++ successData.vader.name


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
