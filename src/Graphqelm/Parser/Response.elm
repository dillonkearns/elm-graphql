module Graphqelm.Parser.Response exposing (Error, errorDecoder)

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
        (Decode.dict Decode.value |> Decode.map (Dict.remove "message"))
        |> Decode.list
        |> Decode.field "errors"
