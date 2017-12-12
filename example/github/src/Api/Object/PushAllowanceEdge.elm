module Api.Object.PushAllowanceEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PushAllowanceEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PushAllowanceEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PushAllowance -> FieldDecoder node Api.Object.PushAllowanceEdge
node object =
    Object.single "node" [] object
