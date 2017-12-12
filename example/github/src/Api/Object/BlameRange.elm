module Api.Object.BlameRange exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


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
