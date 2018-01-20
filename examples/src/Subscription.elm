module Subscription exposing (main)

import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Graphqelm.Subscription
import Html exposing (Html, button, div, fieldset, h1, input, label, li, p, pre, text, ul)
import Html.Attributes exposing (name, type_)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode as Encode
import Swapi.Enum.Phrase as Phrase exposing (Phrase)
import Swapi.Interface
import Swapi.Interface.Character
import Swapi.Mutation as Mutation
import Swapi.Object
import Swapi.Object.ChatMessage
import Swapi.Scalar
import Swapi.Subscription as Subscription


sendMessage : String -> Phrase -> SelectionSet (Maybe ()) Graphqelm.Operation.RootMutation
sendMessage characterId phrase =
    Mutation.selection identity
        |> with (Mutation.sendMessage { characterId = Swapi.Scalar.Id characterId, phrase = phrase } SelectionSet.empty)


document : SelectionSet ChatMessage RootSubscription
document =
    Subscription.selection identity
        |> with (Subscription.newMessage chatMessageSelection)


type alias ChatMessage =
    { phrase : Phrase
    , characterName : Maybe String
    }


chatMessageSelection : SelectionSet ChatMessage Swapi.Object.ChatMessage
chatMessageSelection =
    Swapi.Object.ChatMessage.selection ChatMessage
        |> with Swapi.Object.ChatMessage.phrase
        |> with (Swapi.Object.ChatMessage.character characterSelection)


characterSelection : SelectionSet String Swapi.Interface.Character
characterSelection =
    Swapi.Interface.Character.commonSelection identity
        |> with Swapi.Interface.Character.name


type alias Model =
    { data : List ChatMessage
    , subscriptionStatus : Graphqelm.Subscription.Status
    , graphqlSubscriptionModel : Graphqelm.Subscription.Model Msg ChatMessage
    , characterId : String
    }


type Msg
    = SendMessage Phrase
    | GraphqlSubscriptionMsg (Graphqelm.Subscription.Msg ChatMessage)
    | SubscriptionDataReceived ChatMessage
    | SubscriptionStatusChanged Graphqelm.Subscription.Status
    | ChangeCharacter String


frameworkKnowledge : Graphqelm.Subscription.FrameworkKnowledge subscriptionDecodesTo
frameworkKnowledge =
    { initMessage =
        Encode.list
            [ Encode.string "1"
            , Encode.string "1"
            , Encode.string "__absinthe__:control"
            , Encode.string "phx_join"
            , Encode.object []
            ]
    , heartBeatMessage =
        Encode.list
            [ Encode.null
            , Encode.string "1"
            , Encode.string "phoenix"
            , Encode.string "heartbeat"
            , Encode.object []
            ]
    , documentRequest =
        \operation ->
            Encode.list
                [ Encode.string "1"
                , Encode.string "1"
                , Encode.string "__absinthe__:control"
                , Encode.string "doc"
                , Encode.object [ ( "query", operation |> Encode.string ) ]
                ]
    , subscriptionDecoder =
        \decoder ->
            subscriptionResponseDecoder
                (decoder
                    |> Json.Decode.field "result"
                    |> Json.Decode.index 4
                )
    }


init : ( Model, Cmd Msg )
init =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphqelm.Subscription.init frameworkKnowledge socketUrl document SubscriptionDataReceived
    in
    ( { data = []
      , subscriptionStatus = Graphqelm.Subscription.Uninitialized
      , graphqlSubscriptionModel =
            graphqlSubscriptionModel
                |> Graphqelm.Subscription.onStatusChanged SubscriptionStatusChanged
      , characterId = "1001"
      }
    , graphqlSubscriptionCmd
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Star Chat" ]
        , text ("Phoenix GraphQL Subscription connection status: " ++ toString model.subscriptionStatus)
        , characterRadioButtons
        , messageButtons
        , chatMessagesView model.data
        ]


characterRadioButton : ( String, String ) -> Html.Html Msg
characterRadioButton ( characterId, characterName ) =
    label []
        [ input
            [ type_ "radio", name "character", onClick (ChangeCharacter characterId) ]
            []
        , text characterName
        ]


characterRadioButtons : Html Msg
characterRadioButtons =
    fieldset [] (characters |> List.map characterRadioButton)


messageButtons : Html.Html Msg
messageButtons =
    div []
        [ messageButton Phrase.Faith
        , messageButton Phrase.Father
        , messageButton Phrase.Help
        , messageButton Phrase.TheForce
        , messageButton Phrase.Try
        ]


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


characters : List ( String, String )
characters =
    [ "1000" => "Luke"
    , "1001" => "Vader"
    , "1002" => "Han"
    , "1003" => "Leia"
    , "1004" => "Tarkin"
    , "2000" => "Threepio"
    , "2001" => "Artoo"
    ]


messageButton : Phrase -> Html.Html Msg
messageButton phrase =
    button [ onClick (SendMessage phrase) ] [ phrase |> toString |> text ]


chatMessagesView : List ChatMessage -> Html.Html msg
chatMessagesView model =
    ul []
        (model
            |> List.map
                (\{ phrase, characterName } ->
                    li [] [ ((characterName |> Maybe.withDefault "") ++ ": " ++ (phrase |> phraseToString)) |> text ]
                )
        )


phraseToString : Phrase -> String
phraseToString phrase =
    case phrase of
        Phrase.Faith ->
            "I find your lack of faith disturbing."

        Phrase.Father ->
            "I am your father."

        Phrase.Help ->
            "Help me, Obi-Wan Kenobi. You're my only hope."

        Phrase.TheForce ->
            "May the Force be with you."

        Phrase.Try ->
            "Do, or do not, there is no try."


socketUrl : String
socketUrl =
    "wss://graphqelm.herokuapp.com/socket/websocket?vsn=2.0.0"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
            Graphqelm.Subscription.update graphqlSubscriptionMsg model

        SendMessage phrase ->
            ( model, Graphqelm.Subscription.sendMutation model.graphqlSubscriptionModel (sendMessage model.characterId phrase) )

        SubscriptionDataReceived newData ->
            ( { model | data = newData :: model.data }, Cmd.none )

        SubscriptionStatusChanged newStatus ->
            ( { model | subscriptionStatus = newStatus }, Cmd.none )

        ChangeCharacter characterId ->
            ( { model | characterId = characterId }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Graphqelm.Subscription.subscription model.graphqlSubscriptionModel GraphqlSubscriptionMsg socketUrl document


subscriptionResponseDecoder : Json.Decode.Decoder a -> Json.Decode.Decoder (Graphqelm.Subscription.Response a)
subscriptionResponseDecoder decoder =
    Json.Decode.index 3 Json.Decode.string
        |> Json.Decode.andThen
            (\responseType ->
                if responseType == "subscription:data" then
                    decoder |> Json.Decode.map Graphqelm.Subscription.SubscriptionDataReceived
                else
                    Json.Decode.succeed Graphqelm.Subscription.HealthStatus
            )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
