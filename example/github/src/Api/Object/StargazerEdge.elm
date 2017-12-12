module Api.Object.StargazerEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


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
