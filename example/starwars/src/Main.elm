module Main exposing (..)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object.Character
import Api.Object.Droid
import Api.Query
import GraphqElm.Field
import GraphqElm.Http
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)


type alias Response =
    { heroResponse : Hero
    , droidResponse : String
    }


query : GraphqElm.Field.Query Response
query =
    GraphqElm.Query.combine Response
        (Api.Query.hero (\args -> { args | episode = Just Episode.EMPIRE }) hero)
        (Api.Query.droid { id = "2000" } droid)


type alias Hero =
    { id : String
    , name : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : Object Hero Api.Object.Character.Type
hero =
    Api.Object.Character.build Hero
        |> Object.with Api.Object.Character.id
        |> Object.with Api.Object.Character.name
        |> Object.with (Api.Object.Character.friends heroWithName)
        |> Object.with Api.Object.Character.appearsIn


heroWithName : Object String Api.Object.Character.Type
heroWithName =
    Api.Object.Character.build identity
        |> Object.with Api.Object.Character.name


droid : Object.Object String Api.Object.Droid.Type
droid =
    Api.Object.Droid.build identity
        |> Object.with Api.Object.Droid.name


makeRequest : Cmd Msg
makeRequest =
    query
        |> GraphqElm.Http.request "http://localhost:8080/graphql"
        |> RemoteData.sendRequest
        |> Cmd.map GotResponse


type Msg
    = GotResponse Model


type alias Model =
    WebData Response


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , makeRequest
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (GraphqElm.Field.toQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
