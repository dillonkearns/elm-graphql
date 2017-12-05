module Api.Object.ProjectCardConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectCardConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ProjectCardEdge) Api.Object.ProjectCardConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ProjectCardEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ProjectCard) Api.Object.ProjectCardConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ProjectCard.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectCardConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ProjectCardConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
