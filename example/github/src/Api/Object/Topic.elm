module Api.Object.Topic exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Topic
selection constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Topic
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Topic
name =
    Object.fieldDecoder "name" [] Decode.string


relatedTopics : SelectionSet relatedTopics Api.Object.Topic -> FieldDecoder (List relatedTopics) Api.Object.Topic
relatedTopics object =
    Object.listOf "relatedTopics" [] object
