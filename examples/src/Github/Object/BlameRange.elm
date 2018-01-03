module Github.Object.BlameRange exposing (..)

import Github.Interface
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


{-| Identifies the recency of the change, from 1 (new) to 10 (old). This is calculated as a 2-quantile and determines the length of distance between the median age of all the changes in the file and the recency of the current range's change.
-}
age : FieldDecoder Int Github.Object.BlameRange
age =
    Object.fieldDecoder "age" [] Decode.int


{-| Identifies the line author
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.BlameRange
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


{-| The ending line for the range
-}
endingLine : FieldDecoder Int Github.Object.BlameRange
endingLine =
    Object.fieldDecoder "endingLine" [] Decode.int


{-| The starting line for the range
-}
startingLine : FieldDecoder Int Github.Object.BlameRange
startingLine =
    Object.fieldDecoder "startingLine" [] Decode.int
