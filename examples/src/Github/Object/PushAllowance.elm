module Github.Object.PushAllowance exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PushAllowance
selection constructor =
    Object.object constructor


{-| The actor that can push.
-}
actor : SelectionSet selection Github.Union.PushAllowanceActor -> FieldDecoder (Maybe selection) Github.Object.PushAllowance
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


id : FieldDecoder String Github.Object.PushAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the protected branch associated with the allowed user or team.
-}
protectedBranch : SelectionSet selection Github.Object.ProtectedBranch -> FieldDecoder selection Github.Object.PushAllowance
protectedBranch object =
    Object.selectionFieldDecoder "protectedBranch" [] object identity
