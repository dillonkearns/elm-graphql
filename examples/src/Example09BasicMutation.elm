module Example09BasicMutation exposing (main)

import CustomScalarCodecs
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Enum.Phrase exposing (Phrase(..))
import Swapi.Interface
import Swapi.Interface.Character
import Swapi.Mutation as Mutation exposing (SendMessageRequiredArguments)
import Swapi.Object as Object exposing (ChatMessage)
import Swapi.Object.ChatMessage as ObjChat


type alias Character =
    { name : String
    , avatarUrl : String
    }


type alias ChatMessage =
    { phrase : Phrase
    , character : Maybe Character
    }


type alias Response =
    Maybe ChatMessage


chatSelection : SelectionSet ChatMessage Object.ChatMessage
chatSelection =
    SelectionSet.map2 ChatMessage
        ObjChat.phrase
        (ObjChat.character characterSelection)


characterSelection : SelectionSet Character Swapi.Interface.Character
characterSelection =
    SelectionSet.map2 Character
        Swapi.Interface.Character.name
        Swapi.Interface.Character.avatarUrl


sendChatMutation : SelectionSet Response RootMutation
sendChatMutation =
    Mutation.sendMessage
        { characterId = CustomScalarCodecs.Id 1001, phrase = Droids }
        chatSelection


makeRequest : Cmd Msg
makeRequest =
    sendChatMutation
        |> Graphql.Http.mutationRequest "https://elm-graphql.onrender.com"
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
