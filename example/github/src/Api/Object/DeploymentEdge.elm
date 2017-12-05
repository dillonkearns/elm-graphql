module Api.Object.DeploymentEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeploymentEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.DeploymentEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Deployment -> FieldDecoder node Api.Object.DeploymentEdge
node object =
    Object.single "node" [] object
