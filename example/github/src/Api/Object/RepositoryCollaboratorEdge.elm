module Api.Object.RepositoryCollaboratorEdge exposing (..)

import Api.Enum.RepositoryPermission
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryCollaboratorEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.RepositoryCollaboratorEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.RepositoryCollaboratorEdge
node object =
    Object.single "node" [] object


permission : FieldDecoder Api.Enum.RepositoryPermission.RepositoryPermission Api.Object.RepositoryCollaboratorEdge
permission =
    Field.fieldDecoder "permission" [] Api.Enum.RepositoryPermission.decoder
