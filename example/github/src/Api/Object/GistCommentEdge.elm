module Api.Object.GistCommentEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistCommentEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.GistCommentEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.GistComment -> FieldDecoder node Api.Object.GistCommentEdge
node object =
    Object.single "node" [] object
