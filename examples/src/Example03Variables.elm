module Example03Variables exposing (main)

import Browser
import Graphql.Document as Document
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
    Id "1001"
        |> query
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


view : Model -> Browser.Document Msg
view model =
    { title = "Starwars Demo"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , pre [] [ text (Document.serializeQuery (query (Id "1001"))) ]
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
