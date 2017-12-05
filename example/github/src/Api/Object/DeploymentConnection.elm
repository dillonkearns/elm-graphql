module Api.Object.DeploymentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeploymentConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.DeploymentEdge) Api.Object.DeploymentConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.DeploymentEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Deployment) Api.Object.DeploymentConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Deployment.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.DeploymentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.DeploymentConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
