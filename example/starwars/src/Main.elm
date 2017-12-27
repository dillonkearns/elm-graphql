module Main exposing (main)

import Api.Enum.Episode as Episode exposing (Episode)
import Api.Object
import Api.Object.Character as Character
import Api.Object.Human as Human
import Api.Query as Query
import Graphqelm exposing (RootQuery)
import Graphqelm.Document as Document
import Graphqelm.FieldDecoder as FieldDecoder
import Graphqelm.Http
import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Html exposing (div, h1, p, pre, text)
import RemoteData exposing (RemoteData)


type alias Response =
    { tarkin : Human
    , vader : Human
    , hero : Hero
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.human { id = "1004" } human)
        |> with (Query.human { id = "1001" } human)
        |> with (Query.hero (\optionals -> { optionals | episode = Present Episode.EMPIRE }) hero)


type alias Hero =
    { name : String
    , id : String
    , friends : List String
    , appearsIn : List Episode
    }


hero : SelectionSet Hero Api.Object.Character
hero =
    Character.selection Hero
        |> with Character.name
        |> with Character.id
        |> with (Character.friends heroWithName)
        |> with Character.appearsIn


heroWithName : SelectionSet String Api.Object.Character
heroWithName =
    Character.selection identity
        |> with Character.name


type alias Human =
    { name : String
    , yearsActive : List Int
    }


human : SelectionSet Human Api.Object.Human
human =
    Human.selection Human
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
        |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData Graphqelm.Http.Error Response


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
            , pre [] [ text (Document.serializeQuery query) ]
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
