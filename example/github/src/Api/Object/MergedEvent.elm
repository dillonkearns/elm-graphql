module Api.Object.MergedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MergedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.MergedEvent
actor object =
    Object.single "actor" [] object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.MergedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.MergedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.MergedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


mergeRef : Object mergeRef Api.Object.Ref -> FieldDecoder mergeRef Api.Object.MergedEvent
mergeRef object =
    Object.single "mergeRef" [] object


mergeRefName : FieldDecoder String Api.Object.MergedEvent
mergeRefName =
    Field.fieldDecoder "mergeRefName" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.MergedEvent
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Api.Object.MergedEvent
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.MergedEvent
url =
    Field.fieldDecoder "url" [] Decode.string
