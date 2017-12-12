module Api.Object.ReactingUserEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactingUserEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReactingUserEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.ReactingUserEdge
node object =
    Object.single "node" [] object


reactedAt : FieldDecoder String Api.Object.ReactingUserEdge
reactedAt =
    Object.fieldDecoder "reactedAt" [] Decode.string
