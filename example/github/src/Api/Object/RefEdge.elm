module Api.Object.RefEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RefEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.RefEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Ref -> FieldDecoder node Api.Object.RefEdge
node object =
    Object.single "node" [] object
