module Github.Object.TeamRepositoryEdge exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.TeamRepositoryEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.TeamRepositoryEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet selection Github.Object.Repository -> FieldDecoder selection Github.Object.TeamRepositoryEdge
node object =
    Object.selectionFieldDecoder "node" [] object identity


{-| The permission level the team has on the repository
-}
permission : FieldDecoder Github.Enum.RepositoryPermission.RepositoryPermission Github.Object.TeamRepositoryEdge
permission =
    Object.fieldDecoder "permission" [] Github.Enum.RepositoryPermission.decoder
