module Api.Object.ProjectEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ProjectEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Project -> FieldDecoder node Api.Object.ProjectEdge
node object =
    Object.single "node" [] object
