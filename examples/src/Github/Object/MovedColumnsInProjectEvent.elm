module Github.Object.MovedColumnsInProjectEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MovedColumnsInProjectEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder (Maybe actor) Github.Object.MovedColumnsInProjectEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


createdAt : FieldDecoder String Github.Object.MovedColumnsInProjectEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder (Maybe Int) Github.Object.MovedColumnsInProjectEvent
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.MovedColumnsInProjectEvent
id =
    Object.fieldDecoder "id" [] Decode.string
