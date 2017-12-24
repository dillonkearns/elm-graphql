module Api.Object.RenamedTitleEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RenamedTitleEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.RenamedTitleEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.RenamedTitleEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


currentTitle : FieldDecoder String Api.Object.RenamedTitleEvent
currentTitle =
    Object.fieldDecoder "currentTitle" [] Decode.string


id : FieldDecoder String Api.Object.RenamedTitleEvent
id =
    Object.fieldDecoder "id" [] Decode.string


previousTitle : FieldDecoder String Api.Object.RenamedTitleEvent
previousTitle =
    Object.fieldDecoder "previousTitle" [] Decode.string


subject : FieldDecoder String Api.Object.RenamedTitleEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
