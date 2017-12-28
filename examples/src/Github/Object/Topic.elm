module Github.Object.Topic exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Topic
selection constructor =
    Object.object constructor


id : FieldDecoder String Github.Object.Topic
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Github.Object.Topic
name =
    Object.fieldDecoder "name" [] Decode.string


relatedTopics : SelectionSet relatedTopics Github.Object.Topic -> FieldDecoder (List relatedTopics) Github.Object.Topic
relatedTopics object =
    Object.selectionFieldDecoder "relatedTopics" [] object (identity >> Decode.list)
