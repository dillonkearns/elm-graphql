module Api.Object.PushAllowance exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PushAllowance
selection constructor =
    Object.object constructor


actor : FieldDecoder String Api.Object.PushAllowance
actor =
    Object.fieldDecoder "actor" [] Decode.string


id : FieldDecoder String Api.Object.PushAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


protectedBranch : SelectionSet protectedBranch Api.Object.ProtectedBranch -> FieldDecoder protectedBranch Api.Object.PushAllowance
protectedBranch object =
    Object.single "protectedBranch" [] object
