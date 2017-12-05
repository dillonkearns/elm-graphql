module Api.Object.TeamRepositoryConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamRepositoryConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.TeamRepositoryEdge) Api.Object.TeamRepositoryConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.TeamRepositoryEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Repository) Api.Object.TeamRepositoryConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Repository.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamRepositoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.TeamRepositoryConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
