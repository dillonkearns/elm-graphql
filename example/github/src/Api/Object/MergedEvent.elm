module Api.Object.MergedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.MergedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.MergedEvent
actor object =
    Object.single "actor" [] object


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.MergedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.MergedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.MergedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


mergeRef : SelectionSet mergeRef Api.Object.Ref -> FieldDecoder mergeRef Api.Object.MergedEvent
mergeRef object =
    Object.single "mergeRef" [] object


mergeRefName : FieldDecoder String Api.Object.MergedEvent
mergeRefName =
    Object.fieldDecoder "mergeRefName" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.MergedEvent
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Api.Object.MergedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.MergedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
