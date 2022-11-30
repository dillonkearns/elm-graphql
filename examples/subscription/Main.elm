port module Main exposing (main)

import Browser
import CustomScalarCodecs
import Graphql.Document
import Graphql.Http
import Graphql.Operation exposing (RootSubscription)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (Html, button, div, fieldset, h1, img, input, label, li, p, pre, text, ul)
import Html.Attributes exposing (href, name, src, style, target, type_)
import Html.Events exposing (onClick)
import Json.Decode
import Swapi.Enum.Phrase as Phrase exposing (Phrase)
import Swapi.Interface
import Swapi.Interface.Character
import Swapi.Mutation as Mutation
import Swapi.Object
import Swapi.Object.ChatMessage
import Swapi.Scalar
import Swapi.Subscription as Subscription


sendChatMessage : CustomScalarCodecs.Id -> Phrase -> SelectionSet () Graphql.Operation.RootMutation
sendChatMessage characterId phrase =
    Mutation.sendMessage { characterId = characterId, phrase = phrase } SelectionSet.empty
        |> SelectionSet.map (\_ -> ())


subscriptionDocument : SelectionSet ChatMessage RootSubscription
subscriptionDocument =
    Subscription.newMessage chatMessageSelection


type alias ChatMessage =
    { phrase : Phrase
    , character : Maybe Character
    }


chatMessageSelection : SelectionSet ChatMessage Swapi.Object.ChatMessage
chatMessageSelection =
    SelectionSet.succeed ChatMessage
        |> with Swapi.Object.ChatMessage.phrase
        |> with (Swapi.Object.ChatMessage.character characterSelection)


type alias Character =
    { name : String
    , avatarUrl : String
    }


characterSelection : SelectionSet Character Swapi.Interface.Character
characterSelection =
    SelectionSet.succeed Character
        |> with Swapi.Interface.Character.name
        |> with Swapi.Interface.Character.avatarUrl


type alias Model =
    { data : List ChatMessage
    , characterId : CustomScalarCodecs.Id
    , subscriptionStatus : SubscriptionStatus
    }


type Msg
    = SendMessage Phrase
    | SubscriptionDataReceived Json.Decode.Value
    | SentMessage (Result (Graphql.Http.Error ()) ())
      -- | SubscriptionStatusChanged Graphql.Subscription.Status
    | ChangeCharacter CustomScalarCodecs.Id
    | NewSubscriptionStatus SubscriptionStatus ()


init : () -> ( Model, Cmd Msg )
init flags =
    -- let
    --     ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
    --         Graphql.Subscription.init Protocol.phoenixAbsinthe socketUrl subscriptionDocument SubscriptionDataReceived
    -- in
    ( { data = []

      -- , subscriptionStatus = Graphql.Subscription.Uninitialized
      -- , graphqlSubscriptionModel =
      --       graphqlSubscriptionModel
      --           |> Graphql.Subscription.onStatusChanged SubscriptionStatusChanged
      , characterId = CustomScalarCodecs.Id 1001
      , subscriptionStatus = NotConnected
      }
    , createSubscriptions (subscriptionDocument |> Graphql.Document.serializeSubscription)
    )


port createSubscriptions : String -> Cmd msg


view : Model -> Html.Html Msg
view model =
    case model.subscriptionStatus of
        NotConnected ->
            div []
                [ headingView
                , text "Connecting..."
                ]

        Reconnecting ->
            div []
                [ headingView
                , text "Reconnecting..."
                , chatMessagesView model.data
                ]

        Connected ->
            div []
                [ headingView
                , characterRadioButtons
                , messageButtons
                , chatMessagesView model.data
                ]


headingView =
    div []
        [ h1 []
            [ text "Star Chat - "
            , link
                { url = "https://github.com/dillonkearns/elm-graphql"
                , content = "dillonkearns/elm-graphql"
                }
            , text " Subscriptions Demo"
            ]
        , Html.h2 []
            [ link
                { url = "https://github.com/dillonkearns/elm-graphql/tree/master/examples/subscription"
                , content = "See the code on Github"
                }
            ]
        ]


link { url, content } =
    Html.a
        [ href url, target "_blank" ]
        [ text content ]


characterRadioButton : ( CustomScalarCodecs.Id, String ) -> Html.Html Msg
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
    div [] (List.map messageButton Phrase.list)


characters : List ( CustomScalarCodecs.Id, String )
characters =
    [ character 1000 "Luke"
    , character 1001 "Vader"
    , character 1002 "Han"
    , character 1003 "Leia"
    , character 1004 "Tarkin"
    , character 2000 "Threepio"
    , character 2001 "Artoo"
    ]


character id name =
    ( CustomScalarCodecs.Id id, name )


messageButton : Phrase -> Html.Html Msg
messageButton phrase =
    button [ onClick (SendMessage phrase) ] [ phrase |> phraseToString |> text ]


chatMessagesView : List ChatMessage -> Html.Html msg
chatMessagesView model =
    ul []
        (model
            |> List.map
                (\chatMessage ->
                    let
                        characterName =
                            chatMessage.character |> Maybe.map .name |> Maybe.withDefault ""

                        avatar =
                            chatMessage.character |> Maybe.map .avatarUrl |> Maybe.withDefault ""
                    in
                    li []
                        [ img
                            [ style "width" "40px"
                            , style "padding-right" "5px"
                            , src avatar
                            ]
                            []
                        , (characterName ++ ": " ++ (chatMessage.phrase |> phraseToString)) |> text
                        ]
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
        --     let
        --         ( newModel, cmd ) =
        --             Graphql.Subscription.update graphqlSubscriptionMsg model.graphqlSubscriptionModel
        --     in
        --     ( { model | graphqlSubscriptionModel = newModel }, cmd )
        --
        SendMessage phrase ->
            ( model
            , sendChatMessage model.characterId phrase
                |> Graphql.Http.mutationRequest "https://elm-graphql.onrender.com/"
                |> Graphql.Http.send SentMessage
            )

        SubscriptionDataReceived newData ->
            case Json.Decode.decodeValue (subscriptionDocument |> Graphql.Document.decoder) newData of
                Ok chatMessage ->
                    ( { model | data = chatMessage :: model.data }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        SentMessage _ ->
            ( model, Cmd.none )

        -- SubscriptionStatusChanged newStatus ->
        --     ( { model | subscriptionStatus = newStatus }, Cmd.none )
        ChangeCharacter characterId ->
            ( { model | characterId = characterId }, Cmd.none )

        NewSubscriptionStatus newStatus () ->
            ( { model | subscriptionStatus = newStatus }, Cmd.none )


type SubscriptionStatus
    = NotConnected
    | Connected
    | Reconnecting


subscriptions : Model -> Sub Msg
subscriptions model =
    -- Graphql.Subscription.listen GraphqlSubscriptionMsg model.graphqlSubscriptionModel
    Sub.batch
        [ gotSubscriptionData SubscriptionDataReceived
        , socketStatusConnected (NewSubscriptionStatus Connected)
        , socketStatusReconnecting (NewSubscriptionStatus Reconnecting)
        ]


port gotSubscriptionData : (Json.Decode.Value -> msg) -> Sub msg


port socketStatusConnected : (() -> msg) -> Sub msg


port socketStatusReconnecting : (() -> msg) -> Sub msg


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
