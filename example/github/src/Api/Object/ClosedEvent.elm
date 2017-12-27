module Api.Object.ClosedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ClosedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.ClosedEvent
actor object =
    Object.single "actor" [] object


closable : SelectionSet closable Api.Object.Closable -> FieldDecoder closable Api.Object.ClosedEvent
closable object =
    Object.single "closable" [] object


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.ClosedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.ClosedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ClosedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
