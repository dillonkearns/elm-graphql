module Github.Object.RepositoryCollaboratorEdge exposing (..)

import Github.Enum.RepositoryPermission
import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryCollaboratorEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.RepositoryCollaboratorEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Github.Object.User -> FieldDecoder node Github.Object.RepositoryCollaboratorEdge
node object =
    Object.selectionFieldDecoder "node" [] object identity


{-| The permission the user has on the repository.
-}
permission : FieldDecoder Github.Enum.RepositoryPermission.RepositoryPermission Github.Object.RepositoryCollaboratorEdge
permission =
    Object.fieldDecoder "permission" [] Github.Enum.RepositoryPermission.decoder
