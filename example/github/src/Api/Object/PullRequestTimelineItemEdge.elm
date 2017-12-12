module Api.Object.PullRequestTimelineItemEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestTimelineItemEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PullRequestTimelineItemEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : FieldDecoder String Api.Object.PullRequestTimelineItemEdge
node =
    Object.fieldDecoder "node" [] Decode.string
