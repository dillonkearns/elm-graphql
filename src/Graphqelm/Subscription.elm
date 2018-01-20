module Graphqelm.Subscription exposing (FrameworkKnowledge, Model, Msg, Response(..), init, subscription, update)

import Graphqelm.Document
import Graphqelm.Document.LowLevel
import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode
import Json.Encode as Encode
import Task
import Time exposing (Time)
import WebSocket


type Response a
    = SubscriptionDataReceived a
    | HealthStatus


type Msg a
    = SendHeartbeat Time
    | ResponseReceived (Result String (Response a))


type Status
    = Uninitialized
    | Connected


type Model msg decodesTo
    = Model
        { status : Status
        , subscriptionDocument : SelectionSet decodesTo RootSubscription
        , socketUrl : String
        , onData : decodesTo -> msg
        , frameworkKnowledge : FrameworkKnowledge decodesTo
        }


init : FrameworkKnowledge decodesTo -> String -> SelectionSet decodesTo RootSubscription -> (decodesTo -> msg) -> ( Model msg decodesTo, Cmd msg )
init frameworkKnowledge socketUrl subscriptionDocument onData =
    ( Model
        { status = Uninitialized
        , subscriptionDocument = subscriptionDocument
        , socketUrl = socketUrl
        , onData = onData
        , frameworkKnowledge = frameworkKnowledge
        }
    , WebSocket.send socketUrl (frameworkKnowledge.initMessage |> Encode.encode 0)
    )


subscription :
    Model msg decodesTo
    -> (Msg decodesTo -> msg)
    -> String
    -> Graphqelm.SelectionSet.SelectionSet decodesTo RootSubscription
    -> Sub msg
subscription (Model model) toMsg socketUrl document =
    Sub.batch
        [ WebSocket.listen socketUrl
            (Json.Decode.decodeString (model.frameworkKnowledge.subscriptionDecoder (Graphqelm.Document.LowLevel.decoder document))
                >> ResponseReceived
            )
        , Time.every (30 * Time.second) SendHeartbeat
        ]
        |> Sub.map toMsg


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
                                ( { fullModel | graphqlSubscriptionModel = Model { model | status = Connected } }
                                , WebSocket.send
                                    model.socketUrl
                                    (documentRequest (Graphqelm.Document.serializeSubscription model.subscriptionDocument))
                                )
                            else
                                ( fullModel, Cmd.none )

                        Ok (SubscriptionDataReceived data) ->
                            ( fullModel, Task.succeed data |> Task.perform model.onData )

                        Err errorString ->
                            ( fullModel, Cmd.none )


type alias FrameworkKnowledge subscriptionDecodesTo =
    { documentRequest : String -> Encode.Value
    , heartBeatMessage : Encode.Value
    , initMessage : Encode.Value
    , subscriptionDecoder :
        Json.Decode.Decoder subscriptionDecodesTo
        -> Json.Decode.Decoder (Response subscriptionDecodesTo)
    }
