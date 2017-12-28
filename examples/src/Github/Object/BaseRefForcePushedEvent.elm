module Github.Object.BaseRefForcePushedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.BaseRefForcePushedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.BaseRefForcePushedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


afterCommit : SelectionSet afterCommit Github.Object.Commit -> FieldDecoder afterCommit Github.Object.BaseRefForcePushedEvent
afterCommit object =
    Object.selectionFieldDecoder "afterCommit" [] object identity


beforeCommit : SelectionSet beforeCommit Github.Object.Commit -> FieldDecoder beforeCommit Github.Object.BaseRefForcePushedEvent
beforeCommit object =
    Object.selectionFieldDecoder "beforeCommit" [] object identity


createdAt : FieldDecoder String Github.Object.BaseRefForcePushedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.BaseRefForcePushedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.BaseRefForcePushedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


ref : SelectionSet ref Github.Object.Ref -> FieldDecoder ref Github.Object.BaseRefForcePushedEvent
ref object =
    Object.selectionFieldDecoder "ref" [] object identity
