port module Main exposing (main)

import Graphql.Parser
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode
import Json.Encode.Extra



-- Need to import Json.Decode as a
-- workaround for https://github.com/elm-lang/elm-make/issues/134


workaround : Decoder String
workaround =
    Decode.string


type alias Model =
    ()


type alias Flags =
    { data : Value
    , baseModule : List String
    }


init : Flags -> ( Model, Cmd Never )
init flags =
    case Decode.decodeValue (Graphql.Parser.decoder flags.baseModule) flags.data of
        Ok fields ->
            ( ()
            , fields
                |> Json.Encode.Extra.dict identity Json.Encode.string
                |> generatedFiles
            )

        Err error ->
            Debug.todo ("Got error " ++ Debug.toString error)


main : Program Flags Model Never
main =
    Platform.worker
        { init = init
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


port generatedFiles : Json.Encode.Value -> Cmd msg
