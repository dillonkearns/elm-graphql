module Api.Object.PullRequestCommit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PullRequestCommit
selection constructor =
    Object.object constructor


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestCommit
commit object =
    Object.single "commit" [] object


id : FieldDecoder String Api.Object.PullRequestCommit
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestCommit
pullRequest object =
    Object.single "pullRequest" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestCommit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestCommit
url =
    Object.fieldDecoder "url" [] Decode.string
