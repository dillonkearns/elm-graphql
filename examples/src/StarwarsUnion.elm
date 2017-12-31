module Main exposing (main)

import Graphqelm exposing (RootQuery)
import Graphqelm.Document as Document
import Graphqelm.Http
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)
import Swapi.Enum.Episode as Episode exposing (Episode)
import Swapi.Object
import Swapi.Object.Character as Character
import Swapi.Object.Human as Human
import Swapi.Query as Query


type alias Response =
    { hero : ( String, HumanOrDroid )
    }


type HumanOrDroid
    = Human String (Maybe String)
    | Ignored


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.hero (\optionals -> { optionals | episode = Present Episode.JEDI }) characterWithName human (SelectionSet.ignore Ignored))


characterWithName : SelectionSet String Swapi.Object.Character
characterWithName =
    Character.selection identity
        |> with Character.name


human : SelectionSet HumanOrDroid Swapi.Object.Human
human =
    Human.selection Human
        |> with Human.id
        |> with Human.homePlanet


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "https://graphqelm.herokuapp.com/api"
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData Graphqelm.Http.Error Response


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
