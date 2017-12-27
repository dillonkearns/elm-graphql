module Github.Object.MergedEvent exposing (..)

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


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.MergedEvent
actor object =
    Object.single "actor" [] object


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.MergedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Github.Object.MergedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.MergedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


mergeRef : SelectionSet mergeRef Github.Object.Ref -> FieldDecoder mergeRef Github.Object.MergedEvent
mergeRef object =
    Object.single "mergeRef" [] object


mergeRefName : FieldDecoder String Github.Object.MergedEvent
mergeRefName =
    Object.fieldDecoder "mergeRefName" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.MergedEvent
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Github.Object.MergedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Github.Object.MergedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
