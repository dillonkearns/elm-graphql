module Github.Object.MergedEvent exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MergedEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Interface.Actor -> FieldDecoder (Maybe actor) Github.Object.MergedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the commit associated with the `merge` event.
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.MergedEvent
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.MergedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.MergedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the Ref associated with the `merge` event.
-}
mergeRef : SelectionSet mergeRef Github.Object.Ref -> FieldDecoder (Maybe mergeRef) Github.Object.MergedEvent
mergeRef object =
    Object.selectionFieldDecoder "mergeRef" [] object (identity >> Decode.maybe)


{-| Identifies the name of the Ref associated with the `merge` event.
-}
mergeRefName : FieldDecoder String Github.Object.MergedEvent
mergeRefName =
    Object.fieldDecoder "mergeRefName" [] Decode.string


{-| PullRequest referenced by event.
-}
pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.MergedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| The HTTP path for this merged event.
-}
resourcePath : FieldDecoder String Github.Object.MergedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The HTTP URL for this merged event.
-}
url : FieldDecoder String Github.Object.MergedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
