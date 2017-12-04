port module Main exposing (..)

import Graphqelm.Parser
import Http
import Json.Decode exposing (..)
import Json.Encode
import Json.Encode.Extra


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


init : Flags -> ( Model, Cmd Msg )
init flags =
    case Json.Decode.decodeValue Graphqelm.Parser.decoder flags.data of
        Ok fields ->
            ( ()
            , fields
                |> Json.Encode.Extra.dict identity Json.Encode.string
                |> generatedFiles
            )

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


port generatedFiles : Json.Encode.Value -> Cmd msg


port parsingError : String -> Cmd msg
