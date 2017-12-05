module Api.Object.CommitConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.CommitEdge) Api.Object.CommitConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.CommitEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Commit) Api.Object.CommitConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Commit.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.CommitConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.CommitConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
