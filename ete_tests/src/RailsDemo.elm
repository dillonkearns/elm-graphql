module Subscription exposing (main)

import Api.Object
import Api.Object.Post
import Api.Subscription
import Graphql.Operation exposing (RootMutation, RootSubscription)
import Graphql.SelectionSet exposing (with)
import Graphql.Subscription
import Graphql.Subscription.Protocol exposing (Protocol)
import Html exposing (Html, button, div, fieldset, h1, img, input, label, li, p, pre, text, ul)


subscriptionDocument : Graphql.SelectionSet.SelectionSet Post RootSubscription
subscriptionDocument =
    Api.Subscription.selection identity
        |> with (Api.Subscription.postAdded postSelection)


type alias Post =
    { title : String
    , content : String
    }


postSelection : Graphql.SelectionSet.SelectionSet Post Api.Object.Post
postSelection =
    Api.Object.Post.selection Post
        |> with Api.Object.Post.title
        |> with Api.Object.Post.body


type alias Model =
    { graphqlSubscriptionModel : Graphql.Subscription.Model Msg Post
    , data : List Post
    }


type Msg
    = SubscriptionDataReceived Post
    | GraphqlSubscriptionMsg (Graphql.Subscription.Msg Post)


init : ( Model, Cmd Msg )
init =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphql.Subscription.init Graphql.Subscription.Protocol.rails socketUrl subscriptionDocument SubscriptionDataReceived
    in
    ( { graphqlSubscriptionModel =
            graphqlSubscriptionModel

      -- |> Graphql.Subscription.onStatusChanged SubscriptionStatusChanged
      , data = []
      }
    , graphqlSubscriptionCmd
    )


view : Model -> Html.Html Msg
view model =
    div [] (List.map postView model.data)


postView : Post -> Html Msg
postView post =
    div []
        [ h1 [] [ text post.title ]
        , div [] [ text post.content ]
        ]


socketUrl : String
socketUrl =
    "ws://localhost:8080/subscriptions"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
            Graphql.Subscription.update graphqlSubscriptionMsg model

        SubscriptionDataReceived newPost ->
            ( { model | data = newPost :: model.data }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Graphql.Subscription.listen GraphqlSubscriptionMsg model


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
