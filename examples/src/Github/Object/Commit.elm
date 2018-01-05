module Github.Object.Commit exposing (..)

import Github.Enum.SubscriptionState
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


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Commit
selection constructor =
    Object.selection constructor


{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : FieldDecoder String Github.Object.Commit
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


{-| The number of additions in this commit.
-}
additions : FieldDecoder Int Github.Object.Commit
additions =
    Object.fieldDecoder "additions" [] Decode.int


{-| Authorship details of the commit.
-}
author : SelectionSet selection Github.Object.GitActor -> FieldDecoder (Maybe selection) Github.Object.Commit
author object =
    Object.selectionFieldDecoder "author" [] object (identity >> Decode.maybe)


{-| Check if the committer and the author match.
-}
authoredByCommitter : FieldDecoder Bool Github.Object.Commit
authoredByCommitter =
    Object.fieldDecoder "authoredByCommitter" [] Decode.bool


{-| The datetime when this commit was authored.
-}
authoredDate : FieldDecoder String Github.Object.Commit
authoredDate =
    Object.fieldDecoder "authoredDate" [] Decode.string


{-| Fetches `git blame` information.

  - path - The file whose Git blame information you want.

-}
blame : { path : String } -> SelectionSet selection Github.Object.Blame -> FieldDecoder selection Github.Object.Commit
blame requiredArgs object =
    Object.selectionFieldDecoder "blame" [ Argument.required "path" requiredArgs.path Encode.string ] object identity


{-| The number of changed files in this commit.
-}
changedFiles : FieldDecoder Int Github.Object.Commit
changedFiles =
    Object.fieldDecoder "changedFiles" [] Decode.int


{-| Comments made on the commit.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.CommitCommentConnection -> FieldDecoder selection Github.Object.Commit
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


{-| The HTTP path for this Git object
-}
commitResourcePath : FieldDecoder String Github.Object.Commit
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


{-| The HTTP URL for this Git object
-}
commitUrl : FieldDecoder String Github.Object.Commit
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


{-| The datetime when this commit was committed.
-}
committedDate : FieldDecoder String Github.Object.Commit
committedDate =
    Object.fieldDecoder "committedDate" [] Decode.string


{-| Check if commited via GitHub web UI.
-}
committedViaWeb : FieldDecoder Bool Github.Object.Commit
committedViaWeb =
    Object.fieldDecoder "committedViaWeb" [] Decode.bool


{-| Committership details of the commit.
-}
committer : SelectionSet selection Github.Object.GitActor -> FieldDecoder (Maybe selection) Github.Object.Commit
committer object =
    Object.selectionFieldDecoder "committer" [] object (identity >> Decode.maybe)


{-| The number of deletions in this commit.
-}
deletions : FieldDecoder Int Github.Object.Commit
deletions =
    Object.fieldDecoder "deletions" [] Decode.int


{-| The linear commit history starting from (and including) this commit, in the same order as `git log`.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - path - If non-null, filters history to only show commits touching files under this path.
  - author - If non-null, filters history to only show commits with matching authorship.
  - since - Allows specifying a beginning time or date for fetching commits.
  - until - Allows specifying an ending time or date for fetching commits.

-}
history : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String }) -> SelectionSet selection Github.Object.CommitHistoryConnection -> FieldDecoder selection Github.Object.Commit
history fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, path = Absent, author = Absent, since = Absent, until = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "path" filledInOptionals.path Encode.string, Argument.optional "author" filledInOptionals.author identity, Argument.optional "since" filledInOptionals.since Encode.string, Argument.optional "until" filledInOptionals.until Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "history" optionalArgs object identity


id : FieldDecoder String Github.Object.Commit
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The Git commit message
-}
message : FieldDecoder String Github.Object.Commit
message =
    Object.fieldDecoder "message" [] Decode.string


{-| The Git commit message body
-}
messageBody : FieldDecoder String Github.Object.Commit
messageBody =
    Object.fieldDecoder "messageBody" [] Decode.string


{-| The commit message body rendered to HTML.
-}
messageBodyHTML : FieldDecoder String Github.Object.Commit
messageBodyHTML =
    Object.fieldDecoder "messageBodyHTML" [] Decode.string


{-| The Git commit message headline
-}
messageHeadline : FieldDecoder String Github.Object.Commit
messageHeadline =
    Object.fieldDecoder "messageHeadline" [] Decode.string


{-| The commit message headline rendered to HTML.
-}
messageHeadlineHTML : FieldDecoder String Github.Object.Commit
messageHeadlineHTML =
    Object.fieldDecoder "messageHeadlineHTML" [] Decode.string


{-| The Git object ID
-}
oid : FieldDecoder String Github.Object.Commit
oid =
    Object.fieldDecoder "oid" [] Decode.string


{-| The parents of a commit.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
parents : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.CommitConnection -> FieldDecoder selection Github.Object.Commit
parents fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "parents" optionalArgs object identity


{-| The datetime when this commit was pushed.
-}
pushedDate : FieldDecoder (Maybe String) Github.Object.Commit
pushedDate =
    Object.fieldDecoder "pushedDate" [] (Decode.string |> Decode.maybe)


{-| The Repository this commit belongs to
-}
repository : SelectionSet selection Github.Object.Repository -> FieldDecoder selection Github.Object.Commit
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| The HTTP path for this commit
-}
resourcePath : FieldDecoder String Github.Object.Commit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| Commit signing information, if present.
-}
signature : SelectionSet selection Github.Interface.GitSignature -> FieldDecoder (Maybe selection) Github.Object.Commit
signature object =
    Object.selectionFieldDecoder "signature" [] object (identity >> Decode.maybe)


{-| Status information for this commit
-}
status : SelectionSet selection Github.Object.Status -> FieldDecoder (Maybe selection) Github.Object.Commit
status object =
    Object.selectionFieldDecoder "status" [] object (identity >> Decode.maybe)


{-| Returns a URL to download a tarball archive for a repository. Note: For private repositories, these links are temporary and expire after five minutes.
-}
tarballUrl : FieldDecoder String Github.Object.Commit
tarballUrl =
    Object.fieldDecoder "tarballUrl" [] Decode.string


{-| Commit's root Tree
-}
tree : SelectionSet selection Github.Object.Tree -> FieldDecoder selection Github.Object.Commit
tree object =
    Object.selectionFieldDecoder "tree" [] object identity


{-| The HTTP path for the tree of this commit
-}
treeResourcePath : FieldDecoder String Github.Object.Commit
treeResourcePath =
    Object.fieldDecoder "treeResourcePath" [] Decode.string


{-| The HTTP URL for the tree of this commit
-}
treeUrl : FieldDecoder String Github.Object.Commit
treeUrl =
    Object.fieldDecoder "treeUrl" [] Decode.string


{-| The HTTP URL for this commit
-}
url : FieldDecoder String Github.Object.Commit
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Check if the viewer is able to change their subscription status for the repository.
-}
viewerCanSubscribe : FieldDecoder Bool Github.Object.Commit
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


{-| Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
-}
viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Commit
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder


{-| Returns a URL to download a zipball archive for a repository. Note: For private repositories, these links are temporary and expire after five minutes.
-}
zipballUrl : FieldDecoder String Github.Object.Commit
zipballUrl =
    Object.fieldDecoder "zipballUrl" [] Decode.string
