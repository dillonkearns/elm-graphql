module Github.Object.PushAllowance exposing (..)

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


actor : FieldDecoder String Github.Object.PushAllowance
actor =
    Object.fieldDecoder "actor" [] Decode.string


id : FieldDecoder String Github.Object.PushAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


protectedBranch : SelectionSet protectedBranch Github.Object.ProtectedBranch -> FieldDecoder protectedBranch Github.Object.PushAllowance
protectedBranch object =
    Object.selectionFieldDecoder "protectedBranch" [] object identity
