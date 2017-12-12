module Api.Object.ReactionEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactionEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReactionEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Reaction -> FieldDecoder node Api.Object.ReactionEdge
node object =
    Object.single "node" [] object
