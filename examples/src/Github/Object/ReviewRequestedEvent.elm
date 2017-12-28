module Github.Object.ReviewRequestedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewRequestedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.ReviewRequestedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


createdAt : FieldDecoder String Github.Object.ReviewRequestedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReviewRequestedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.ReviewRequestedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


requestedReviewer : FieldDecoder String Github.Object.ReviewRequestedEvent
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


subject : SelectionSet subject Github.Object.User -> FieldDecoder subject Github.Object.ReviewRequestedEvent
subject object =
    Object.selectionFieldDecoder "subject" [] object identity
