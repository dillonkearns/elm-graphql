module Api.Object.ReviewRequestRemovedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewRequestRemovedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReviewRequestRemovedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.ReviewRequestRemovedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ReviewRequestRemovedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewRequestRemovedEvent
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewer : FieldDecoder String Api.Object.ReviewRequestRemovedEvent
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


subject : Object subject Api.Object.User -> FieldDecoder subject Api.Object.ReviewRequestRemovedEvent
subject object =
    Object.single "subject" [] object
