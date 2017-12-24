module Api.Object.DemilestonedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.DemilestonedEvent
selection constructor =
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
