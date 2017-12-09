module Api.Object.PullRequestTimelineItemEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestTimelineItemEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PullRequestTimelineItemEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : FieldDecoder String Api.Object.PullRequestTimelineItemEdge
node =
    Object.fieldDecoder "node" [] Decode.string
