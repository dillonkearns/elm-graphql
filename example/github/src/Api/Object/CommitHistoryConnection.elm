module Api.Object.CommitHistoryConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitHistoryConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.CommitEdge) Api.Object.CommitHistoryConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.CommitEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Commit) Api.Object.CommitHistoryConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Commit.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.CommitHistoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.CommitHistoryConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
