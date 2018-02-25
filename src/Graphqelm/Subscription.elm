module Graphqelm.Subscription
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

import Graphqelm.Document
import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.Subscription.Protocol as Protocol exposing (Protocol)
import Json.Decode
import Json.Encode as Encode
import Task
import Time exposing (Time)
import WebSocket


{-| An opaque type that needs to be passed through to the `Subscription.update` function
in your program's `update`.

    type Msg
        = GraphqlSubscriptionMsg (Graphqelm.Subscription.Msg ChatMessage)
        | SubscriptionDataReceived ChatMessage

    update : Msg -> Model -> ( Model, Cmd Msg )
    update msg model =
        case msg of
            GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
                Graphqelm.Subscription.update graphqlSubscriptionMsg model

            SubscriptionDataReceived newData ->
                ( { model | data = newData :: model.data }, Cmd.none )

    subscriptions : Model -> Sub Msg
    subscriptions model =
        Graphqelm.Subscription.subscription model.graphqlSubscriptionModel GraphqlSubscriptionMsg socketUrl document

-}
type Msg a
    = SendHeartbeat Time
    | ResponseReceived (Result String (Protocol.Response a))


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
    -> SelectionSet mutationDecodesTo Graphqelm.Operation.RootMutation
    -> Cmd msg
sendMutation (Model model) mutationDocument =
    let
        documentRequest =
            model.protocol.documentRequest model.referenceId >> Encode.encode 0
    in
    WebSocket.send model.socketUrl (documentRequest (Graphqelm.Document.serializeMutation mutationDocument))


{-| Initialize a Subscription. You will need a `Graphqelm.Subscription.Protocol`
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
    , WebSocket.send socketUrl (protocol.initMessage 1 |> Encode.encode 0)
    )


{-| Register a Msg to receive when a connection is established.

    init : ( Model, Cmd Msg )
    init =
        let
            ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
                Graphqelm.Subscription.init protocol socketUrl subscriptionDocument SubscriptionDataReceived
        in
        ( { data = []
          , subscriptionStatus = Graphqelm.Subscription.Uninitialized
          , graphqlSubscriptionModel =
                graphqlSubscriptionModel
                    |> Graphqelm.Subscription.onStatusChanged SubscriptionStatusChanged
          }
        , graphqlSubscriptionCmd
        )

-}
onStatusChanged : (Status -> msg) -> Model msg decodesTo -> Model msg decodesTo
onStatusChanged onStatusChanged (Model model) =
    Model { model | onStatusChanged = Just onStatusChanged }


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
                [ WebSocket.listen model.socketUrl
                    (Debug.log "raw response"
                        >> Json.Decode.decodeString
                            (model.protocol.subscriptionDecoder
                                (Graphqelm.Document.decoder model.subscriptionDocument)
                            )
                        >> ResponseReceived
                    )
                , Time.every (30 * Time.second) SendHeartbeat
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
                    , WebSocket.send model.socketUrl (model.protocol.heartBeatMessage model.referenceId |> Encode.encode 0)
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
                                , WebSocket.send
                                    model.socketUrl
                                    (documentRequest (Graphqelm.Document.serializeSubscription model.subscriptionDocument))
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

                    Just onStatusChanged ->
                        Task.succeed newStatus |> Task.perform onStatusChanged
                ]
            )


incrementRefId : Model msg decodesTo -> Model msg decodesTo
incrementRefId graphqlSubscriptionModel =
    case graphqlSubscriptionModel of
        Model model ->
            Model { model | referenceId = model.referenceId + 1 }
