module Api.Object.IssueCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueCommentConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.IssueCommentEdge) Api.Object.IssueCommentConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.IssueCommentEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.IssueComment) Api.Object.IssueCommentConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.IssueComment.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.IssueCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.IssueCommentConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
