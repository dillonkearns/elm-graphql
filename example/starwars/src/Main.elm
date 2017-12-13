module Main exposing (main)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object
import Api.Object.Character as Character
import Api.Object.Human as Human
import Api.Query as Query
import Graphqelm exposing (RootQuery)
import Graphqelm.DocumentSerializer as DocumentSerializer
import Graphqelm.FieldDecoder as FieldDecoder
import Graphqelm.Http
import Graphqelm.Object exposing (Object, with)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (WebData)


type alias Response =
    { tarkin : Human
    , vader : Human
    , hero : Hero
    }


query : Object Response RootQuery
query =
    Query.build Response
        |> with (Query.human { id = "1004" } human)
        |> with (Query.human { id = "1001" } human)
        |> with (Query.hero identity hero)


type alias Hero =
    { name : String
    , id : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : Object Hero Api.Object.Character
hero =
    Character.build Hero
        |> with Character.name
        |> with Character.id
        |> with (Character.friends heroWithName)
        |> with Character.appearsIn


heroWithName : Object String Api.Object.Character
heroWithName =
    Character.build identity
        |> with Character.name


type alias Human =
    { name : String
    , yearsActive : List Int
    }


human : Object Human Api.Object.Human
human =
    Human.build Human
        |> with Human.name
        |> with (Human.appearsIn |> FieldDecoder.map (List.map episodeYear))


episodeYear : Episode -> Int
episodeYear episode =
    case episode of
        Episode.NEWHOPE ->
            1977

        Episode.EMPIRE ->
            1980

        Episode.JEDI ->
            1983


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphqelm.Http.buildQueryRequest "https://graphqelm.herokuapp.com/api"
        |> Graphqelm.Http.toRequest
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
            , pre [] [ text (DocumentSerializer.serializeQuery query) ]
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
