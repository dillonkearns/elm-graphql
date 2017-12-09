module Api.Object.LabeledEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


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
