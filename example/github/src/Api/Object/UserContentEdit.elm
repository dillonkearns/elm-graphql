module Api.Object.UserContentEdit exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UserContentEdit
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.UserContentEdit
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.UserContentEdit
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.UserContentEdit
id =
    Field.fieldDecoder "id" [] Decode.string


updatedAt : FieldDecoder String Api.Object.UserContentEdit
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string
