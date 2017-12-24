module Api.Object.UserContentEdit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.UserContentEdit
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.UserContentEdit
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.UserContentEdit
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.UserContentEdit
id =
    Object.fieldDecoder "id" [] Decode.string


updatedAt : FieldDecoder String Api.Object.UserContentEdit
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string
