module Api.Object.CommitCommentEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitCommentEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.CommitCommentEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.CommitComment -> FieldDecoder node Api.Object.CommitCommentEdge
node object =
    Object.single "node" [] object
