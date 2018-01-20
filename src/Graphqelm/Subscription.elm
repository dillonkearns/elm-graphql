module Graphqelm.Subscription
    exposing
        ( FrameworkKnowledge
        , Model
        , Msg
        , Response(..)
        , Status(..)
        , init
        , listen
        , onStatusChanged
        , sendMutation
        , update
        )

{-|

@docs FrameworkKnowledge

@docs Model, Msg, Response, Status, init, onStatusChanged, sendMutation, listen, update

-}

import Graphqelm.Document
import Graphqelm.Document.LowLevel
import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode
import Json.Encode as Encode
import Task
import Time exposing (Time)
import WebSocket


{-| Low-level type used for building FrameworkKnowledge. Represents incoming server messages.
-}
type Response a
    = SubscriptionDataReceived a
    | HealthStatus


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
    | ResponseReceived (Result String (Response a))


{-| The Subscription connection status. Use `onStatusChanged` to register a Msg to listen for this.
-}
type Status
    = Uninitialized
    | Connected


{-| Model
-}
type Model msg decodesTo
    = Model
        { status : Status
        , subscriptionDocument : SelectionSet decodesTo RootSubscription
        , socketUrl : String
        , onData : decodesTo -> msg
        , onStatusChanged : Maybe (Status -> msg)
        , frameworkKnowledge : FrameworkKnowledge decodesTo
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
            model.frameworkKnowledge.documentRequest >> Encode.encode 0
    in
    WebSocket.send model.socketUrl (documentRequest (Graphqelm.Document.serializeMutation mutationDocument))


{-| Initialize a Subscription (passed in to `listen`).
-}
init : FrameworkKnowledge decodesTo -> String -> SelectionSet decodesTo RootSubscription -> (decodesTo -> msg) -> ( Model msg decodesTo, Cmd msg )
init frameworkKnowledge socketUrl subscriptionDocument onData =
    ( Model
        { status = Uninitialized
        , subscriptionDocument = subscriptionDocument
        , socketUrl = socketUrl
        , onData = onData
        , onStatusChanged = Nothing
        , frameworkKnowledge = frameworkKnowledge
        }
    , WebSocket.send socketUrl (frameworkKnowledge.initMessage |> Encode.encode 0)
    )


{-| Register a Msg to receive when a connection is established.

    init : ( Model, Cmd Msg )
    init =
        let
            ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
                Graphqelm.Subscription.init frameworkKnowledge socketUrl subscriptionDocument SubscriptionDataReceived
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
    -> { model | graphqlSubscriptionModel : Model msg decodesTo }
    -> Sub msg
listen toMsg { graphqlSubscriptionModel } =
    case graphqlSubscriptionModel of
        Model model ->
            Sub.batch
                [ WebSocket.listen model.socketUrl
                    (Json.Decode.decodeString (model.frameworkKnowledge.subscriptionDecoder (Graphqelm.Document.LowLevel.decoder model.subscriptionDocument))
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
    -> { model | graphqlSubscriptionModel : Model msg decodesTo }
    -> ( { model | graphqlSubscriptionModel : Model msg decodesTo }, Cmd msg )
update msg ({ graphqlSubscriptionModel } as fullModel) =
    case graphqlSubscriptionModel of
        Model model ->
            case msg of
                SendHeartbeat time ->
                    ( fullModel, WebSocket.send model.socketUrl (model.frameworkKnowledge.heartBeatMessage |> Encode.encode 0) )

                ResponseReceived response ->
                    let
                        documentRequest =
                            model.frameworkKnowledge.documentRequest >> Encode.encode 0
                    in
                    case response of
                        Ok HealthStatus ->
                            if model.status == Uninitialized then
                                ( fullModel
                                , WebSocket.send
                                    model.socketUrl
                                    (documentRequest (Graphqelm.Document.serializeSubscription model.subscriptionDocument))
                                )
                                    |> setStatus Connected
                            else
                                ( fullModel, Cmd.none )

                        Ok (SubscriptionDataReceived data) ->
                            ( fullModel, Task.succeed data |> Task.perform model.onData )

                        Err errorString ->
                            let
                                _ =
                                    Debug.log "Error" errorString
                            in
                            ( fullModel, Cmd.none )


setStatus :
    Status
    -> ( { a | graphqlSubscriptionModel : Model msg decodesTo }, Cmd msg )
    -> ( { a | graphqlSubscriptionModel : Model msg decodesTo }, Cmd msg )
setStatus newStatus ( { graphqlSubscriptionModel } as fullModel, cmds ) =
    case graphqlSubscriptionModel of
        Model model ->
            ( { fullModel | graphqlSubscriptionModel = Model { model | status = newStatus } }
            , Cmd.batch
                [ cmds
                , case model.onStatusChanged of
                    Nothing ->
                        Cmd.none

                    Just onStatusChanged ->
                        Task.succeed newStatus |> Task.perform onStatusChanged
                ]
            )


{-| This encapsulates the Subscriptions protocol for a specific framework, like Phoenix/Absinthe.
The low-level details of how to initiate a connection and check that it was successful, etc., can be
very different between GraphQL server implementations. Here is an example for the Absinthe framework
for Elixir/Phoenix:

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

-}
type alias FrameworkKnowledge subscriptionDecodesTo =
    { documentRequest : String -> Encode.Value
    , heartBeatMessage : Encode.Value
    , initMessage : Encode.Value
    , subscriptionDecoder :
        Json.Decode.Decoder subscriptionDecodesTo
        -> Json.Decode.Decoder (Response subscriptionDecodesTo)
    }
