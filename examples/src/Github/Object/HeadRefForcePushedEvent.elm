module Github.Object.HeadRefForcePushedEvent exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.HeadRefForcePushedEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Interface.Actor -> FieldDecoder (Maybe actor) Github.Object.HeadRefForcePushedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the after commit SHA for the 'head_ref_force_pushed' event.
-}
afterCommit : SelectionSet afterCommit Github.Object.Commit -> FieldDecoder (Maybe afterCommit) Github.Object.HeadRefForcePushedEvent
afterCommit object =
    Object.selectionFieldDecoder "afterCommit" [] object (identity >> Decode.maybe)


{-| Identifies the before commit SHA for the 'head_ref_force_pushed' event.
-}
beforeCommit : SelectionSet beforeCommit Github.Object.Commit -> FieldDecoder (Maybe beforeCommit) Github.Object.HeadRefForcePushedEvent
beforeCommit object =
    Object.selectionFieldDecoder "beforeCommit" [] object (identity >> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.HeadRefForcePushedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.HeadRefForcePushedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| PullRequest referenced by event.
-}
pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.HeadRefForcePushedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| Identifies the fully qualified ref name for the 'head_ref_force_pushed' event.
-}
ref : SelectionSet ref Github.Object.Ref -> FieldDecoder (Maybe ref) Github.Object.HeadRefForcePushedEvent
ref object =
    Object.selectionFieldDecoder "ref" [] object (identity >> Decode.maybe)
