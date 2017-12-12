module Api.Object.DemilestonedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DemilestonedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.DemilestonedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.DemilestonedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.DemilestonedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


milestoneTitle : FieldDecoder String Api.Object.DemilestonedEvent
milestoneTitle =
    Object.fieldDecoder "milestoneTitle" [] Decode.string


subject : FieldDecoder String Api.Object.DemilestonedEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
