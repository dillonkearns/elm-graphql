module Api.Object.UserContentEdit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UserContentEdit
build constructor =
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
