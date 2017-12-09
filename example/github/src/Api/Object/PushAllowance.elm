module Api.Object.PushAllowance exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PushAllowance
build constructor =
    Object.object constructor


actor : FieldDecoder String Api.Object.PushAllowance
actor =
    Object.fieldDecoder "actor" [] Decode.string


id : FieldDecoder String Api.Object.PushAllowance
id =
    Object.fieldDecoder "id" [] Decode.string


protectedBranch : Object protectedBranch Api.Object.ProtectedBranch -> FieldDecoder protectedBranch Api.Object.PushAllowance
protectedBranch object =
    Object.single "protectedBranch" [] object
