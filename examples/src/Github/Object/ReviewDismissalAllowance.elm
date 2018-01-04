module Github.Object.ReviewDismissalAllowance exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewDismissalAllowance
selection constructor =
    Object.object constructor


{-| The actor that can dismiss.
-}
actor : SelectionSet actor Github.Union.ReviewDismissalAllowanceActor -> FieldDecoder (Maybe actor) Github.Object.ReviewDismissalAllowance
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


id : FieldDecoder String Github.Object.ReviewDismissalAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the protected branch associated with the allowed user or team.
-}
protectedBranch : SelectionSet protectedBranch Github.Object.ProtectedBranch -> FieldDecoder protectedBranch Github.Object.ReviewDismissalAllowance
protectedBranch object =
    Object.selectionFieldDecoder "protectedBranch" [] object identity
