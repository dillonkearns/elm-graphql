module Api.Object.BlameRange exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.BlameRange
build constructor =
    Object.object constructor


age : FieldDecoder Int Api.Object.BlameRange
age =
    Object.fieldDecoder "age" [] Decode.int


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.BlameRange
commit object =
    Object.single "commit" [] object


endingLine : FieldDecoder Int Api.Object.BlameRange
endingLine =
    Object.fieldDecoder "endingLine" [] Decode.int


startingLine : FieldDecoder Int Api.Object.BlameRange
startingLine =
    Object.fieldDecoder "startingLine" [] Decode.int
