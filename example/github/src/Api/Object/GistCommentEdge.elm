module Api.Object.GistCommentEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistCommentEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.GistCommentEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.GistComment -> FieldDecoder node Api.Object.GistCommentEdge
node object =
    Object.single "node" [] object
