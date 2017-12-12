module Api.Object.LabeledEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LabeledEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.LabeledEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.LabeledEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.LabeledEvent
id =
    Object.fieldDecoder "id" [] Decode.string


label : Object label Api.Object.Label -> FieldDecoder label Api.Object.LabeledEvent
label object =
    Object.single "label" [] object


labelable : Object labelable Api.Object.Labelable -> FieldDecoder labelable Api.Object.LabeledEvent
labelable object =
    Object.single "labelable" [] object
