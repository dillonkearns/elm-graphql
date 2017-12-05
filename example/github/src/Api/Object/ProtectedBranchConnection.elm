module Api.Object.ProtectedBranchConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProtectedBranchConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ProtectedBranchEdge) Api.Object.ProtectedBranchConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ProtectedBranchEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ProtectedBranch) Api.Object.ProtectedBranchConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ProtectedBranch.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProtectedBranchConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ProtectedBranchConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
