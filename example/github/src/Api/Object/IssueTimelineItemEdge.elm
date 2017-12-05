module Api.Object.IssueTimelineItemEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueTimelineItemEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.IssueTimelineItemEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : FieldDecoder String Api.Object.IssueTimelineItemEdge
node =
    Field.fieldDecoder "node" [] Decode.string
