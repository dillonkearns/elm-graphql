module Api.Object.MilestonedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MilestonedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.MilestonedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.MilestonedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.MilestonedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


milestoneTitle : FieldDecoder String Api.Object.MilestonedEvent
milestoneTitle =
    Field.fieldDecoder "milestoneTitle" [] Decode.string


subject : FieldDecoder String Api.Object.MilestonedEvent
subject =
    Field.fieldDecoder "subject" [] Decode.string
