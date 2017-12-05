module Api.Object.RepositoryConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.RepositoryEdge) Api.Object.RepositoryConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.RepositoryEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Repository) Api.Object.RepositoryConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Repository.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RepositoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.RepositoryConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string


totalDiskUsage : FieldDecoder String Api.Object.RepositoryConnection
totalDiskUsage =
    Field.fieldDecoder "totalDiskUsage" [] Decode.string
