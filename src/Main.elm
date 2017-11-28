port module Main exposing (..)

import GraphqElm.Generator.Group
import GraphqElm.Generator.Module
import GraphqElm.Parser
import Http
import Json.Decode exposing (..)


-- Need to import Json.Decode as a
-- workaround for https://github.com/elm-lang/elm-make/issues/134


workaround : Decoder String
workaround =
    Json.Decode.string


type alias Model =
    ()


type alias Flags =
    { data : Json.Decode.Value }


type Msg
    = GotSchema (Result.Result Http.Error String)


queryFile : GraphqElm.Generator.Group.Group -> String
queryFile fields =
    GraphqElm.Generator.Module.generateNew fields


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        fieldsResult =
            Json.Decode.decodeValue GraphqElm.Parser.decoderNew flags.data
    in
    case fieldsResult of
        Ok fields ->
            ( (), generatedFiles (queryFile fields) )

        Err error ->
            Debug.crash ("Got error " ++ toString error)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSchema response ->
            let
                _ =
                    Debug.log "response" response
            in
            ( model, Cmd.none )


main : Program Flags Model Msg
main =
    Platform.programWithFlags
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }


port generatedFiles : String -> Cmd msg


port parsingError : String -> Cmd msg
