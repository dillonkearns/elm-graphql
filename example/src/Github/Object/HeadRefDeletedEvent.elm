module Github.Object.HeadRefDeletedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.HeadRefDeletedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.HeadRefDeletedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Github.Object.HeadRefDeletedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


headRef : SelectionSet headRef Github.Object.Ref -> FieldDecoder headRef Github.Object.HeadRefDeletedEvent
headRef object =
    Object.single "headRef" [] object


headRefName : FieldDecoder String Github.Object.HeadRefDeletedEvent
headRefName =
    Object.fieldDecoder "headRefName" [] Decode.string


id : FieldDecoder String Github.Object.HeadRefDeletedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.HeadRefDeletedEvent
pullRequest object =
    Object.single "pullRequest" [] object
