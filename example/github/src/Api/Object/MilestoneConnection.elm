module Api.Object.MilestoneConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MilestoneConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.MilestoneEdge) Api.Object.MilestoneConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.MilestoneEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Milestone) Api.Object.MilestoneConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Milestone.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.MilestoneConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.MilestoneConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
