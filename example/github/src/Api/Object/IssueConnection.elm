module Api.Object.IssueConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.IssueEdge) Api.Object.IssueConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.IssueEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Issue) Api.Object.IssueConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Issue.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.IssueConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.IssueConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
