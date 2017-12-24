module Api.Object.PullRequestTimelineConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestTimelineConnection
selection constructor =
    Object.object constructor


edges : Object edges Api.Object.PullRequestTimelineItemEdge -> FieldDecoder (List edges) Api.Object.PullRequestTimelineConnection
edges object =
    Object.listOf "edges" [] object


nodes : FieldDecoder (List String) Api.Object.PullRequestTimelineConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestTimelineConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.PullRequestTimelineConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
