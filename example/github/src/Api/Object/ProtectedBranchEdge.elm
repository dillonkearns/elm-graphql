module Api.Object.ProtectedBranchEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProtectedBranchEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ProtectedBranchEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.ProtectedBranch -> FieldDecoder node Api.Object.ProtectedBranchEdge
node object =
    Object.single "node" [] object
