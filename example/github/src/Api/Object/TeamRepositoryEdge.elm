module Api.Object.TeamRepositoryEdge exposing (..)

import Api.Enum.RepositoryPermission
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamRepositoryEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamRepositoryEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Repository -> FieldDecoder node Api.Object.TeamRepositoryEdge
node object =
    Object.single "node" [] object


permission : FieldDecoder Api.Enum.RepositoryPermission.RepositoryPermission Api.Object.TeamRepositoryEdge
permission =
    Field.fieldDecoder "permission" [] Api.Enum.RepositoryPermission.decoder
