module Starwars exposing (main)

import Graphql.Document as Document
import Graphql.Field as Field
import Graphql.Http
import Graphql.Http.GraphqlError
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (RemoteData)
import Swapi.Object
import Swapi.Object.Human as Human
import Swapi.Query as Query
import Swapi.Scalar


type alias Response =
    { vader : Human

    -- uncomment lines 21 and 30 to see an unrecoverable error
    -- , unrecoverableError : String
    , forcedError : Maybe String
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.human { id = Swapi.Scalar.Id "1001" } human |> Field.nonNullOrFail)
        -- |> with (Query.forcedError |> Field.nonNullOrFail)
        |> with Query.forcedError


type alias Human =
    { name : String }


human : SelectionSet Human Swapi.Object.Human
human =
    Human.selection Human
        |> with Human.name


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


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
            , pre [] [ responseDetails model |> text ]
            ]
        ]


responseDetails : RemoteData (Graphql.Http.Error Response) Response -> String
responseDetails model =
    case model of
        RemoteData.Failure error ->
            case error of
                Graphql.Http.GraphqlError possiblyParsedData errors ->
                    "GraphQL errors: \n"
                        ++ toString errors
                        ++ "\n\n"
                        ++ (case possiblyParsedData of
                                Graphql.Http.GraphqlError.UnparsedData unparsed ->
                                    "Unable to parse data, got: " ++ toString unparsed

                                Graphql.Http.GraphqlError.ParsedData parsedData ->
                                    "Parsed error data, so I can extract the name from the structured data... parsedData.vader.name = " ++ parsedData.vader.name
                           )

                Graphql.Http.HttpError httpError ->
                    "Http error " ++ toString httpError

        RemoteData.Loading ->
            "Loading"

        RemoteData.NotAsked ->
            "Not Asked"

        RemoteData.Success successData ->
            "Request succeeded so I can use the structred data here... successData.vader.name = " ++ successData.vader.name


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Program Never Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
