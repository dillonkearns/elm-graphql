module Graphqelm.Parser.Response exposing (errorDecoder)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)


type alias Error =
    { message : String
    , details : Dict String Decode.Value
    }


errorDecoder : Decoder (List Error)
errorDecoder =
    Decode.map2 Error
        (Decode.field "message" Decode.string)
        (Decode.succeed Dict.empty)
        |> Decode.list
        |> Decode.field "errors"
