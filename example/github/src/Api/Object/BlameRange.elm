module Api.Object.BlameRange exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.BlameRange
build constructor =
    Object.object constructor


age : FieldDecoder Int Api.Object.BlameRange
age =
    Field.fieldDecoder "age" [] Decode.int


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.BlameRange
commit object =
    Object.single "commit" [] object


endingLine : FieldDecoder Int Api.Object.BlameRange
endingLine =
    Field.fieldDecoder "endingLine" [] Decode.int


startingLine : FieldDecoder Int Api.Object.BlameRange
startingLine =
    Field.fieldDecoder "startingLine" [] Decode.int
