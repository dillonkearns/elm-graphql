module Graphqelm.Subscription exposing (Model, Msg, init, subscription, update)

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
        }


init : String -> SelectionSet decodesTo RootSubscription -> (decodesTo -> msg) -> ( Model msg decodesTo, Cmd msg )
init socketUrl subscriptionDocument onData =
    ( Model
        { status = Uninitialized
        , subscriptionDocument = subscriptionDocument
        , socketUrl = socketUrl
        , onData = onData
        }
    , WebSocket.send socketUrl (frameworkKnowledge.initMessage |> Encode.encode 0)
    )


subscription :
    (Msg decodesTo -> msg)
    -> String
    -> Graphqelm.SelectionSet.SelectionSet decodesTo RootSubscription
    -> Sub msg
subscription toMsg socketUrl document =
    Sub.batch
        [ WebSocket.listen socketUrl
            (Json.Decode.decodeString (frameworkKnowledge.subscriptionDecoder (Graphqelm.Document.LowLevel.decoder document))
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
                    ( fullModel, WebSocket.send model.socketUrl (frameworkKnowledge.heartBeatMessage |> Encode.encode 0) )

                ResponseReceived response ->
                    let
                        documentRequest =
                            frameworkKnowledge.documentRequest >> Encode.encode 0
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


frameworkKnowledge :
    { documentRequest : String -> Encode.Value
    , heartBeatMessage : Encode.Value
    , initMessage : Encode.Value
    , subscriptionDecoder :
        Json.Decode.Decoder a -> Json.Decode.Decoder (Response a)
    }
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


subscriptionResponseDecoder : Json.Decode.Decoder a -> Json.Decode.Decoder (Response a)
subscriptionResponseDecoder decoder =
    Json.Decode.index 3 Json.Decode.string
        |> Json.Decode.andThen
            (\responseType ->
                if responseType == "subscription:data" then
                    decoder |> Json.Decode.map SubscriptionDataReceived
                else
                    Json.Decode.succeed HealthStatus
            )
