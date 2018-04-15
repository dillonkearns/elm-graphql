module Starwars exposing (main)

import Graphqelm.Document as Document
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent, Null, Present))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (div, h1, p, pre, text)
import Normalize.InputObject
import Normalize.Query as Query
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    { value : String
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.type_ (\optionals -> { optionals | input = Present (Normalize.InputObject.buildReservedWord { type_ = "Hi!" }) }))


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.queryRequest "http://localhost:4000"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphqelm.Http.Error Response) Response


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
