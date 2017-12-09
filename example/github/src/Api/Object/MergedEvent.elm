module Api.Object.MergedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


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
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.MergedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


mergeRef : Object mergeRef Api.Object.Ref -> FieldDecoder mergeRef Api.Object.MergedEvent
mergeRef object =
    Object.single "mergeRef" [] object


mergeRefName : FieldDecoder String Api.Object.MergedEvent
mergeRefName =
    Object.fieldDecoder "mergeRefName" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.MergedEvent
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Api.Object.MergedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.MergedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
