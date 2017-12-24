module Api.Object.BlameRange exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.BlameRange
selection constructor =
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
