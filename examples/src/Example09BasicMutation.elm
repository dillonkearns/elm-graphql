module Example09BasicMutation exposing (main)

import CustomScalarCodecs
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Enum.Phrase exposing (Phrase(..))
import Swapi.Mutation as Mutation exposing (SendMessageRequiredArguments)
import Swapi.Object as Object exposing (ChatMessage)
import Swapi.Object.ChatMessage as ObjChat


type alias ChatMessage =
    { phrase : Phrase
    }


type alias Response =
    Maybe ChatMessage


chatSelection : SelectionSet ChatMessage Object.ChatMessage
chatSelection =
    SelectionSet.map ChatMessage
        ObjChat.phrase


sendChatMutation : SelectionSet Response RootMutation
sendChatMutation =
    Mutation.sendMessage
        (SendMessageRequiredArguments (CustomScalarCodecs.Id 1001) Droids)
        chatSelection


makeRequest : Cmd Msg
makeRequest =
    sendChatMutation
        |> Graphql.Http.mutationRequest "https://elm-graphql.herokuapp.com"
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
        , queryString = Document.serializeMutation sendChatMutation
        }
