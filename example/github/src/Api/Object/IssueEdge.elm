module Api.Object.IssueEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.IssueEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Issue -> FieldDecoder node Api.Object.IssueEdge
node object =
    Object.single "node" [] object
