module Api.Object.PushAllowanceEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PushAllowanceEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PushAllowanceEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PushAllowance -> FieldDecoder node Api.Object.PushAllowanceEdge
node object =
    Object.single "node" [] object
