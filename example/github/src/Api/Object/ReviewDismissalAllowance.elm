module Api.Object.ReviewDismissalAllowance exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewDismissalAllowance
build constructor =
    Object.object constructor


actor : FieldDecoder String Api.Object.ReviewDismissalAllowance
actor =
    Field.fieldDecoder "actor" [] Decode.string


id : FieldDecoder String Api.Object.ReviewDismissalAllowance
id =
    Field.fieldDecoder "id" [] Decode.string


protectedBranch : Object protectedBranch Api.Object.ProtectedBranch -> FieldDecoder protectedBranch Api.Object.ReviewDismissalAllowance
protectedBranch object =
    Object.single "protectedBranch" [] object
