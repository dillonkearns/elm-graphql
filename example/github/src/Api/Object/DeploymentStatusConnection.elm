module Api.Object.DeploymentStatusConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeploymentStatusConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.DeploymentStatusEdge) Api.Object.DeploymentStatusConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.DeploymentStatusEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.DeploymentStatus) Api.Object.DeploymentStatusConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.DeploymentStatus.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.DeploymentStatusConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.DeploymentStatusConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
