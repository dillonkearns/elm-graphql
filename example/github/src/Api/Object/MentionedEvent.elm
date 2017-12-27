module Api.Object.MentionedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.MentionedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.MentionedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.MentionedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.MentionedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.MentionedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
