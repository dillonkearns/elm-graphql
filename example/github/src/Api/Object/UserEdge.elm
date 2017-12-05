module Api.Object.UserEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UserEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.UserEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.UserEdge
node object =
    Object.single "node" [] object
