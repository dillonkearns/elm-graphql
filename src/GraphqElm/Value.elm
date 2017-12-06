module Graphqelm.Value exposing (..)

import Json.Encode


type Value
    = EnumValue String
    | Json Json.Encode.Value


valueToString : Value -> String
valueToString value =
    case value of
        EnumValue value ->
            value

        Json json ->
            Json.Encode.encode 0 json
