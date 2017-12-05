module Api.Object.ProjectConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ProjectEdge) Api.Object.ProjectConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ProjectEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Project) Api.Object.ProjectConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Project.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ProjectConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
