module Main exposing (main)

import Browser
import DemoData exposing (DemoData(..))
import Graphql.Field as Field
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData)
import StarWars.Object
import StarWars.Object.Character as Character
import StarWars.Query as Query
import StarWars.Scalar
import View


type alias Response =
    { vader : CharacterInfo
    }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with
            (Query.character
                { id = StarWars.Scalar.Id "1001" }
                characterSelection
                |> Field.nonNullOrFail
            )


type alias CharacterInfo =
    { name : String
    }


characterSelection : SelectionSet CharacterInfo StarWars.Object.Character
characterSelection =
    Character.selection CharacterInfo
        |> with Character.name


charactersFromResponse : Response -> List CharacterInfo
charactersFromResponse response =
    [ response.vader ]


getCharacterData : CharacterInfo -> View.Data
getCharacterData character =
    { name = TODO
    , avatarUrl = TODO
    , homePlanet = TODO
    , friendNames = TODO
    }



{-



   Boilerplate
















-}


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "http://localhost:4000"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


init : () -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading
    , makeRequest
    )


view : Model -> Browser.Document Msg
view model =
    View.view query mainView model


mainView : Response -> Html.Html Msg
mainView response =
    div []
        (response
            |> charactersFromResponse
            |> List.map getCharacterData
            |> List.map View.characterView
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
