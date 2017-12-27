module Api.Object.IssueTimelineItemEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.IssueTimelineItemEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.IssueTimelineItemEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : FieldDecoder String Api.Object.IssueTimelineItemEdge
node =
    Object.fieldDecoder "node" [] Decode.string
