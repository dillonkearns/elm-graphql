module Github.Object.BlameRange exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.BlameRange
selection constructor =
    Object.object constructor


age : FieldDecoder Int Github.Object.BlameRange
age =
    Object.fieldDecoder "age" [] Decode.int


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.BlameRange
commit object =
    Object.single "commit" [] object


endingLine : FieldDecoder Int Github.Object.BlameRange
endingLine =
    Object.fieldDecoder "endingLine" [] Decode.int


startingLine : FieldDecoder Int Github.Object.BlameRange
startingLine =
    Object.fieldDecoder "startingLine" [] Decode.int
