module Graphql.Subscription
    exposing
        ( Model
        , Msg
        , Status(..)
        , init
        , listen
        , onStatusChanged
        , sendMutation
        , update
        )

{-| _Warning_ The Subscriptions functionality in this package is in a highly experimental stage
and may change rapidly or have issues that make it not ready for production code yet.

@docs Model, Msg, Status, init, onStatusChanged, sendMutation, listen, update

-}

import Graphql.Document
import Graphql.Operation exposing (RootSubscription)
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.Subscription.Protocol as Protocol exposing (Protocol)
import Json.Decode as Decode
import Json.Encode as Encode
import Task
import Time



-- TODO
--import WebSocket


webSocketListen _ _ =
    Debug.todo "WebSocket.listen"


webSocketSend _ _ =
    Debug.todo "WebSocket.send"


{-| An opaque type that needs to be passed through to the `Subscription.update` function
in your program's `update`.

    type Msg
        = GraphqlSubscriptionMsg (Graphql.Subscription.Msg ChatMessage)
        | SubscriptionDataReceived ChatMessage

    update : Msg -> Model -> ( Model, Cmd Msg )
    update msg model =
        case msg of
            GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
                Graphql.Subscription.update graphqlSubscriptionMsg model

            SubscriptionDataReceived newData ->
                ( { model | data = newData :: model.data }, Cmd.none )

    subscriptions : Model -> Sub Msg
    subscriptions model =
        Graphql.Subscription.subscription model.graphqlSubscriptionModel GraphqlSubscriptionMsg socketUrl document

-}
type Msg a
    = SendHeartbeat Time.Posix
    | ResponseReceived (Result Decode.Error (Protocol.Response a))


{-| The Subscription connection status. Use `onStatusChanged` to register a Msg to listen for this.
-}
type Status
    = Uninitialized
    | Connected


{-| Model
-}
type Model msg decodesTo
    = Model
        { referenceId : Int
        , status : Status
        , subscriptionDocument : SelectionSet decodesTo RootSubscription
        , socketUrl : String
        , onData : decodesTo -> msg
        , onStatusChanged : Maybe (Status -> msg)
        , protocol : Protocol decodesTo
        }


{-| Performs the mutation over the websocket. If the connection is uninitialized,
it will be dropped.
TODO: should it always be queued? Or should it optionally be queued?
-}
sendMutation :
    Model msg decodesTo
    -> SelectionSet mutationDecodesTo Graphql.Operation.RootMutation
    -> Cmd msg
sendMutation (Model model) mutationDocument =
    let
        documentRequest =
            model.protocol.documentRequest model.referenceId >> Encode.encode 0
    in
    webSocketSend model.socketUrl (documentRequest (Graphql.Document.serializeMutation mutationDocument))


{-| Initialize a Subscription. You will need a `Graphql.Subscription.Protocol`
data structure (the `Protocol` module contains `Protocol`s for some
GraphQL server implementations).
-}
init : Protocol decodesTo -> String -> SelectionSet decodesTo RootSubscription -> (decodesTo -> msg) -> ( Model msg decodesTo, Cmd msg )
init protocol socketUrl subscriptionDocument onData =
    ( Model
        { referenceId = 2
        , status = Uninitialized
        , subscriptionDocument = subscriptionDocument
        , socketUrl = socketUrl
        , onData = onData
        , onStatusChanged = Nothing
        , protocol = protocol
        }
    , webSocketSend socketUrl (protocol.initMessage 1 |> Encode.encode 0)
    )


{-| Register a Msg to receive when a connection is established.

    init : ( Model, Cmd Msg )
    init =
        let
            ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
                Graphql.Subscription.init protocol socketUrl subscriptionDocument SubscriptionDataReceived
        in
        ( { data = []
          , subscriptionStatus = Graphql.Subscription.Uninitialized
          , graphqlSubscriptionModel =
                graphqlSubscriptionModel
                    |> Graphql.Subscription.onStatusChanged SubscriptionStatusChanged
          }
        , graphqlSubscriptionCmd
        )

-}
onStatusChanged : (Status -> msg) -> Model msg decodesTo -> Model msg decodesTo
onStatusChanged onStatusChanged_ (Model model) =
    Model { model | onStatusChanged = Just onStatusChanged_ }


{-| Add this to your subscriptions.
-}
listen :
    (Msg decodesTo -> msg)
    -> Model msg decodesTo
    -> Sub msg
listen toMsg graphqlSubscriptionModel =
    case graphqlSubscriptionModel of
        Model model ->
            Sub.batch
                [ webSocketListen model.socketUrl
                    (Debug.log "raw response"
                        >> Decode.decodeString
                            (model.protocol.subscriptionDecoder
                                (Graphql.Document.decoder model.subscriptionDocument)
                            )
                        >> ResponseReceived
                    )
                , Time.every (30 * 1000) SendHeartbeat
                ]
                |> Sub.map toMsg


{-| Needs to be called from your program's `update` function in order to listen
for and respond to Subscription communications.
-}
update :
    Msg decodesTo
    -> Model msg decodesTo
    -> ( Model msg decodesTo, Cmd msg )
update msg graphqlSubscriptionModel =
    case graphqlSubscriptionModel of
        Model model ->
            case msg of
                SendHeartbeat time ->
                    ( graphqlSubscriptionModel |> incrementRefId
                    , webSocketSend model.socketUrl (model.protocol.heartBeatMessage model.referenceId |> Encode.encode 0)
                    )

                ResponseReceived response ->
                    let
                        _ =
                            Debug.log "Response: " response

                        documentRequest =
                            model.protocol.documentRequest model.referenceId >> Encode.encode 0
                    in
                    case response of
                        Ok Protocol.HealthStatus ->
                            if model.status == Uninitialized then
                                ( graphqlSubscriptionModel |> incrementRefId
                                , webSocketSend
                                    model.socketUrl
                                    (documentRequest (Graphql.Document.serializeSubscription model.subscriptionDocument))
                                )
                                    |> setStatus Connected

                            else
                                ( graphqlSubscriptionModel, Cmd.none )

                        Ok (Protocol.SubscriptionDataReceived data) ->
                            ( graphqlSubscriptionModel, Task.succeed data |> Task.perform model.onData )

                        Err errorString ->
                            let
                                _ =
                                    Debug.log "Error" errorString
                            in
                            ( graphqlSubscriptionModel, Cmd.none )

                        Ok (Protocol.Ignored ignoredContent) ->
                            let
                                _ =
                                    Debug.log "Ignored: " ignoredContent
                            in
                            ( graphqlSubscriptionModel, Cmd.none )


setStatus :
    Status
    -> ( Model msg decodesTo, Cmd msg )
    -> ( Model msg decodesTo, Cmd msg )
setStatus newStatus ( graphqlSubscriptionModel, cmds ) =
    case graphqlSubscriptionModel of
        Model model ->
            ( Model { model | status = newStatus }
            , Cmd.batch
                [ cmds
                , case model.onStatusChanged of
                    Nothing ->
                        Cmd.none

                    Just onStatusChanged_ ->
                        Task.succeed newStatus |> Task.perform onStatusChanged_
                ]
            )


incrementRefId : Model msg decodesTo -> Model msg decodesTo
incrementRefId graphqlSubscriptionModel =
    case graphqlSubscriptionModel of
        Model model ->
            Model { model | referenceId = model.referenceId + 1 }
