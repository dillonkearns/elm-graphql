module Api.Object.ReleaseEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReleaseEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Release -> FieldDecoder node Api.Object.ReleaseEdge
node object =
    Object.single "node" [] object
