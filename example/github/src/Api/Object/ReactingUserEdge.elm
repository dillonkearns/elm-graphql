module Api.Object.ReactingUserEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactingUserEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReactingUserEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.ReactingUserEdge
node object =
    Object.single "node" [] object


reactedAt : FieldDecoder String Api.Object.ReactingUserEdge
reactedAt =
    Field.fieldDecoder "reactedAt" [] Decode.string
