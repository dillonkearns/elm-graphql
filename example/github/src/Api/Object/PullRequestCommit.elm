module Api.Object.PullRequestCommit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestCommit
build constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestCommit
commit object =
    Object.single "commit" [] object


id : FieldDecoder String Api.Object.PullRequestCommit
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestCommit
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestCommit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestCommit
url =
    Object.fieldDecoder "url" [] Decode.string
