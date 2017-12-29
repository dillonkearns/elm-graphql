module Github.Object.PullRequestCommit exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequestCommit
selection constructor =
    Object.object constructor


{-| The Git commit object
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.PullRequestCommit
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


id : FieldDecoder String Github.Object.PullRequestCommit
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The pull request this commit belongs to
-}
pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.PullRequestCommit
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| The HTTP path for this pull request commit
-}
resourcePath : FieldDecoder String Github.Object.PullRequestCommit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The HTTP URL for this pull request commit
-}
url : FieldDecoder String Github.Object.PullRequestCommit
url =
    Object.fieldDecoder "url" [] Decode.string
