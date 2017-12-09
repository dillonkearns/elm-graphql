module Api.Object.StargazerEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.StargazerEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.StargazerEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.StargazerEdge
node object =
    Object.single "node" [] object


starredAt : FieldDecoder String Api.Object.StargazerEdge
starredAt =
    Object.fieldDecoder "starredAt" [] Decode.string
