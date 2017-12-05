module Api.Object.CommitCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitCommentConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.CommitCommentEdge) Api.Object.CommitCommentConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.CommitCommentEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.CommitComment) Api.Object.CommitCommentConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.CommitComment.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.CommitCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.CommitCommentConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
