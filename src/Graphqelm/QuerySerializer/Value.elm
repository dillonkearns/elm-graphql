module Graphqelm.QuerySerializer.Value exposing (serialize)

import Graphqelm.Value exposing (Value(..))
import Json.Encode


serialize : Value -> String
serialize value =
    case value of
        EnumValue value ->
            value

        Json json ->
            Json.Encode.encode 0 json

        List values ->
            "["
                ++ (List.map serialize values |> String.join ", ")
                ++ "]"

        String value ->
            toString value

        Boolean value ->
            toString value

        Integer value ->
            toString value
