module Api.Object.RepositoryCollaboratorEdge exposing (..)

import Api.Enum.RepositoryPermission
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryCollaboratorEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.RepositoryCollaboratorEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.RepositoryCollaboratorEdge
node object =
    Object.single "node" [] object


permission : FieldDecoder Api.Enum.RepositoryPermission.RepositoryPermission Api.Object.RepositoryCollaboratorEdge
permission =
    Object.fieldDecoder "permission" [] Api.Enum.RepositoryPermission.decoder
