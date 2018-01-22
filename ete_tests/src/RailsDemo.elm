module Subscription exposing (main)

import Api.Object
import Api.Object.Post
import Api.Subscription
import Graphqelm.Operation exposing (RootMutation, RootSubscription)
import Graphqelm.SelectionSet exposing (with)
import Graphqelm.Subscription
import Html exposing (Html, button, div, fieldset, h1, img, input, label, li, p, pre, text, ul)
import Json.Decode
import Json.Encode as Encode


subscriptionDocument : Graphqelm.SelectionSet.SelectionSet Post RootSubscription
subscriptionDocument =
    Api.Subscription.selection identity
        |> with (Api.Subscription.postAdded postSelection)


type alias Post =
    { title : String
    , content : String
    }


postSelection : Graphqelm.SelectionSet.SelectionSet Post Api.Object.Post
postSelection =
    Api.Object.Post.selection Post
        |> with Api.Object.Post.title
        |> with Api.Object.Post.body


type alias Model =
    { graphqlSubscriptionModel : Graphqelm.Subscription.Model Msg Post
    , data : List Post
    }


type Msg
    = SubscriptionDataReceived Post
    | GraphqlSubscriptionMsg (Graphqelm.Subscription.Msg Post)


init : ( Model, Cmd Msg )
init =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphqelm.Subscription.init frameworkKnowledge socketUrl subscriptionDocument SubscriptionDataReceived
    in
    ( { graphqlSubscriptionModel =
            graphqlSubscriptionModel

      -- |> Graphqelm.Subscription.onStatusChanged SubscriptionStatusChanged
      , data = []
      }
    , graphqlSubscriptionCmd
    )


frameworkKnowledge : Graphqelm.Subscription.FrameworkKnowledge subscriptionDecodesTo
frameworkKnowledge =
    { initMessage =
        \referenceId ->
            Encode.object
                [ "command" => Encode.string "subscribe"
                , "identifier" => Encode.string "{\"channel\":\"GraphqlChannel\",\"channelId\":\"ElmGraphql\"}"
                ]
    , heartBeatMessage =
        \referenceId ->
            Encode.list
                [ Encode.null
                , Encode.string (toString referenceId)
                , Encode.string "phoenix"
                , Encode.string "heartbeat"
                , Encode.object []
                ]
    , documentRequest =
        \referenceId operation ->
            -- identifier and data are redundantly JSON encoded as per the Action Cable protocol, see:
            --  https://github.com/NullVoxPopuli/action_cable_client#the-action-cable-protocol
            Encode.object
                [ "command" => Encode.string "message"
                , "identifier"
                    => Encode.string
                        (Encode.object [ "channel" => Encode.string "GraphqlChannel", "channelId" => Encode.string "ElmGraphql" ] |> Encode.encode 0)
                , "data"
                    => (Encode.object
                            [ "query"
                                => (operation |> Encode.string)
                            , "action" => Encode.string "execute"
                            ]
                            |> Encode.encode 0
                            |> Encode.string
                       )
                ]
    , subscriptionDecoder =
        subscriptionResponseDecoder
    }


subscriptionResponseDecoder : Json.Decode.Decoder a -> Json.Decode.Decoder (Graphqelm.Subscription.Response a)
subscriptionResponseDecoder decoder =
    Json.Decode.oneOf
        [ Json.Decode.at [ "message", "result" ] decoder
            |> Json.Decode.map Graphqelm.Subscription.SubscriptionDataReceived
        , Json.Decode.field "type" Json.Decode.string
            |> Json.Decode.andThen
                (\type_ ->
                    if type_ == "confirm_subscription" then
                        Json.Decode.succeed Graphqelm.Subscription.HealthStatus
                    else if type_ == "ping" then
                        Json.Decode.succeed Graphqelm.Subscription.HealthStatus
                    else
                        Json.Decode.succeed (Graphqelm.Subscription.Ignored ("Type was not confirm_subscription: " ++ type_))
                )
        ]


view : Model -> Html.Html Msg
view model =
    div [] (List.map postView model.data)


postView : Post -> Html Msg
postView post =
    div []
        [ h1 [] [ text post.title ]
        , div [] [ text post.content ]
        ]


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


socketUrl : String
socketUrl =
    "ws://localhost:8080/subscriptions"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
            Graphqelm.Subscription.update graphqlSubscriptionMsg model

        SubscriptionDataReceived newPost ->
            ( { model | data = newPost :: model.data }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Graphqelm.Subscription.listen GraphqlSubscriptionMsg model


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
