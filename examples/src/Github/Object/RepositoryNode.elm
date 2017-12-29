module Github.Object.RepositoryNode exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryNode
selection constructor =
    Object.object constructor


{-| The repository associated with this node.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.RepositoryNode
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
