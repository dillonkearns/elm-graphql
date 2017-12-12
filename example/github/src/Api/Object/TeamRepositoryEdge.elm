module Api.Object.TeamRepositoryEdge exposing (..)

import Api.Enum.RepositoryPermission
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamRepositoryEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamRepositoryEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Repository -> FieldDecoder node Api.Object.TeamRepositoryEdge
node object =
    Object.single "node" [] object


permission : FieldDecoder Api.Enum.RepositoryPermission.RepositoryPermission Api.Object.TeamRepositoryEdge
permission =
    Object.fieldDecoder "permission" [] Api.Enum.RepositoryPermission.decoder
