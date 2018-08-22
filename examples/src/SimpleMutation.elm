module SimpleMutation exposing (main)

import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (div, h1, p, pre, text)
import PrintAny
import RemoteData exposing (RemoteData)
import Swapi.Mutation as Mutation


type alias Response =
    { counterValue : Int
    }


mutation : SelectionSet Response RootMutation
mutation =
    Mutation.selection Response
        |> with Mutation.increment


makeRequest : Cmd Msg
makeRequest =
    mutation
        |> Graphql.Http.mutationRequest "https://elm-graphql.herokuapp.com"
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
            , pre [] [ text (Document.serializeMutation mutation) ]
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
