module Api.Object.TeamEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Team -> FieldDecoder node Api.Object.TeamEdge
node object =
    Object.single "node" [] object
