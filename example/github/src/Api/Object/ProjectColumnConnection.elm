module Api.Object.ProjectColumnConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectColumnConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ProjectColumnEdge) Api.Object.ProjectColumnConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ProjectColumnEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ProjectColumn) Api.Object.ProjectColumnConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ProjectColumn.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectColumnConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ProjectColumnConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
