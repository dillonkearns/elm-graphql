module Github.Object.IssueComment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.ReactionContent
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.IssueComment
selection constructor =
    Object.selection constructor


{-| The actor who authored the comment.
-}
author : SelectionSet selection Github.Interface.Actor -> FieldDecoder (Maybe selection) Github.Object.IssueComment
author object =
    Object.selectionFieldDecoder "author" [] object (identity >> Decode.maybe)


{-| Author's association with the subject of the comment.
-}
authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.IssueComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


{-| Identifies the comment body.
-}
body : FieldDecoder String Github.Object.IssueComment
body =
    Object.fieldDecoder "body" [] Decode.string


{-| The comment body rendered to HTML.
-}
bodyHTML : FieldDecoder String Github.Object.IssueComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


{-| Identifies the body of the issue rendered to text.
-}
bodyText : FieldDecoder String Github.Object.IssueComment
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.IssueComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Check if this comment was created via an email reply.
-}
createdViaEmail : FieldDecoder Bool Github.Object.IssueComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


{-| The actor who edited the comment.
-}
editor : SelectionSet selection Github.Interface.Actor -> FieldDecoder (Maybe selection) Github.Object.IssueComment
editor object =
    Object.selectionFieldDecoder "editor" [] object (identity >> Decode.maybe)


id : FieldDecoder String Github.Object.IssueComment
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the issue associated with the comment.
-}
issue : SelectionSet selection Github.Object.Issue -> FieldDecoder selection Github.Object.IssueComment
issue object =
    Object.selectionFieldDecoder "issue" [] object identity


{-| The moment the editor made the last edit
-}
lastEditedAt : FieldDecoder (Maybe String) Github.Object.IssueComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] (Decode.string |> Decode.maybe)


{-| Identifies when the comment was published at.
-}
publishedAt : FieldDecoder (Maybe String) Github.Object.IssueComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] (Decode.string |> Decode.maybe)


{-| Returns the pull request associated with the comment, if this comment was made on a
pull request.
-}
pullRequest : SelectionSet selection Github.Object.PullRequest -> FieldDecoder (Maybe selection) Github.Object.IssueComment
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object (identity >> Decode.maybe)


{-| A list of reactions grouped by content left on the subject.
-}
reactionGroups : SelectionSet selection Github.Object.ReactionGroup -> FieldDecoder (Maybe (List selection)) Github.Object.IssueComment
reactionGroups object =
    Object.selectionFieldDecoder "reactionGroups" [] object (identity >> Decode.list >> Decode.maybe)


{-| A list of Reactions left on the Issue.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - content - Allows filtering Reactions by emoji.
  - orderBy - Allows specifying the order in which reactions are returned.

-}
reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet selection Github.Object.ReactionConnection -> FieldDecoder selection Github.Object.IssueComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum Github.Enum.ReactionContent.toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reactions" optionalArgs object identity


{-| The repository associated with this node.
-}
repository : SelectionSet selection Github.Object.Repository -> FieldDecoder selection Github.Object.IssueComment
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| The HTTP path for this issue comment
-}
resourcePath : FieldDecoder String Github.Object.IssueComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The HTTP URL for this issue comment
-}
url : FieldDecoder String Github.Object.IssueComment
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Check if the current viewer can delete this object.
-}
viewerCanDelete : FieldDecoder Bool Github.Object.IssueComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


{-| Can user react to this subject
-}
viewerCanReact : FieldDecoder Bool Github.Object.IssueComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


{-| Check if the current viewer can update this object.
-}
viewerCanUpdate : FieldDecoder Bool Github.Object.IssueComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


{-| Reasons why the current viewer can not update this comment.
-}
viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.IssueComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


{-| Did the viewer author this comment.
-}
viewerDidAuthor : FieldDecoder Bool Github.Object.IssueComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
