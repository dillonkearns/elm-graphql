module Github.Object.ReviewRequestRemovedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewRequestRemovedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.ReviewRequestRemovedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


createdAt : FieldDecoder String Github.Object.ReviewRequestRemovedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReviewRequestRemovedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.ReviewRequestRemovedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


requestedReviewer : FieldDecoder String Github.Object.ReviewRequestRemovedEvent
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


subject : SelectionSet subject Github.Object.User -> FieldDecoder subject Github.Object.ReviewRequestRemovedEvent
subject object =
    Object.selectionFieldDecoder "subject" [] object identity
