module Api.Object.PullRequestTimelineConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestTimelineConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PullRequestTimelineItemEdge) Api.Object.PullRequestTimelineConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PullRequestTimelineItemEdge.decoder |> Decode.list)


nodes : FieldDecoder (List String) Api.Object.PullRequestTimelineConnection
nodes =
    Field.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestTimelineConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PullRequestTimelineConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
