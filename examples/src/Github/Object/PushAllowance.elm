module Github.Object.PushAllowance exposing (..)

import Github.Interface
import Github.Object
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
actor : FieldDecoder (Maybe String) Github.Object.PushAllowance
actor =
    Object.fieldDecoder "actor" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.PushAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the protected branch associated with the allowed user or team.
-}
protectedBranch : SelectionSet protectedBranch Github.Object.ProtectedBranch -> FieldDecoder protectedBranch Github.Object.PushAllowance
protectedBranch object =
    Object.selectionFieldDecoder "protectedBranch" [] object identity
