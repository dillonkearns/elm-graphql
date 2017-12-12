module Api.Object.SearchResultItemEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SearchResultItemEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.SearchResultItemEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : FieldDecoder String Api.Object.SearchResultItemEdge
node =
    Object.fieldDecoder "node" [] Decode.string
