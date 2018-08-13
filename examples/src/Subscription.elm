module Subscription exposing (main)

import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Graphqelm.Subscription
import Graphqelm.Subscription.Protocol as Protocol
import Html exposing (Html, button, div, fieldset, h1, img, input, label, li, p, pre, text, ul)
import Html.Attributes exposing (name, src, style, type_)
import Html.Events exposing (onClick)
import Swapi.Enum.Phrase as Phrase exposing (Phrase)
import Swapi.Interface
import Swapi.Interface.Character
import Swapi.Mutation as Mutation
import Swapi.Object
import Swapi.Object.ChatMessage
import Swapi.Scalar
import Swapi.Subscription as Subscription


sendChatMessage : String -> Phrase -> SelectionSet (Maybe ()) Graphqelm.Operation.RootMutation
sendChatMessage characterId phrase =
    Mutation.selection identity
        |> with (Mutation.sendMessage { characterId = Swapi.Scalar.Id characterId, phrase = phrase } SelectionSet.empty)


subscriptionDocument : SelectionSet ChatMessage RootSubscription
subscriptionDocument =
    Subscription.selection identity
        |> with (Subscription.newMessage chatMessageSelection)


type alias ChatMessage =
    { phrase : Phrase
    , character : Maybe Character
    }


chatMessageSelection : SelectionSet ChatMessage Swapi.Object.ChatMessage
chatMessageSelection =
    Swapi.Object.ChatMessage.selection ChatMessage
        |> with Swapi.Object.ChatMessage.phrase
        |> with (Swapi.Object.ChatMessage.character characterSelection)


type alias Character =
    { name : String
    , avatarUrl : String
    }


characterSelection : SelectionSet Character Swapi.Interface.Character
characterSelection =
    Swapi.Interface.Character.commonSelection Character
        |> with Swapi.Interface.Character.name
        |> with Swapi.Interface.Character.avatarUrl


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


init : ( Model, Cmd Msg )
init =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphqelm.Subscription.init Protocol.phoenixAbsinthe socketUrl subscriptionDocument SubscriptionDataReceived
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
        ([ Phrase.Faith
         , Phrase.Father
         , Phrase.Help
         , Phrase.TheForce
         , Phrase.Try
         , Phrase.BadFeeling
         , Phrase.Droids
         , Phrase.Traitor
         , Phrase.Trap
         ]
            |> List.map messageButton
        )


characters : List ( String, String )
characters =
    [ ( "1000", "Luke" )
    , ( "1001", "Vader" )
    , ( "1002", "Han" )
    , ( "1003", "Leia" )
    , ( "1004", "Tarkin" )
    , ( "2000", "Threepio" )
    , ( "2001", "Artoo" )
    ]


messageButton : Phrase -> Html.Html Msg
messageButton phrase =
    button [ onClick (SendMessage phrase) ] [ phrase |> toString |> text ]


chatMessagesView : List ChatMessage -> Html.Html msg
chatMessagesView model =
    ul []
        (model
            |> List.map
                (\{ phrase, character } ->
                    let
                        characterName =
                            character |> Maybe.map .name |> Maybe.withDefault ""

                        avatar =
                            character |> Maybe.map .avatarUrl |> Maybe.withDefault ""
                    in
                    li [] [ img [ style [ ( "width", "40px" ), ( "padding-right", "5px" ) ], src avatar ] [], (characterName ++ ": " ++ (phrase |> phraseToString)) |> text ]
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

        Phrase.BadFeeling ->
            "I've got a bad feeling about this."

        Phrase.Droids ->
            "These aren't the droids you're looking for."

        Phrase.Traitor ->
            "You are a part of the Rebel Alliance and a traitor!"

        Phrase.Trap ->
            "It's a trap!"


socketUrl : String
socketUrl =
    "wss://graphqelm.herokuapp.com/socket/websocket?vsn=2.0.0"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
            let
                ( newModel, cmd ) =
                    Graphqelm.Subscription.update graphqlSubscriptionMsg model.graphqlSubscriptionModel
            in
            ( { model | graphqlSubscriptionModel = newModel }, cmd )

        SendMessage phrase ->
            ( model, Graphqelm.Subscription.sendMutation model.graphqlSubscriptionModel (sendChatMessage model.characterId phrase) )

        SubscriptionDataReceived newData ->
            ( { model | data = newData :: model.data }, Cmd.none )

        SubscriptionStatusChanged newStatus ->
            ( { model | subscriptionStatus = newStatus }, Cmd.none )

        ChangeCharacter characterId ->
            ( { model | characterId = characterId }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Graphqelm.Subscription.listen GraphqlSubscriptionMsg model.graphqlSubscriptionModel


main : Program Never Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
