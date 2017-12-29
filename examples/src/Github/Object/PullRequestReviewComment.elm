module Github.Object.PullRequestReviewComment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.ReactionContent
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequestReviewComment
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.Actor -> FieldDecoder (Maybe author) Github.Object.PullRequestReviewComment
author object =
    Object.selectionFieldDecoder "author" [] object (identity >> Decode.maybe)


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.PullRequestReviewComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.PullRequestReviewComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.PullRequestReviewComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Github.Object.PullRequestReviewComment
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.PullRequestReviewComment
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


createdAt : FieldDecoder String Github.Object.PullRequestReviewComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.PullRequestReviewComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder (Maybe Int) Github.Object.PullRequestReviewComment
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


diffHunk : FieldDecoder String Github.Object.PullRequestReviewComment
diffHunk =
    Object.fieldDecoder "diffHunk" [] Decode.string


draftedAt : FieldDecoder String Github.Object.PullRequestReviewComment
draftedAt =
    Object.fieldDecoder "draftedAt" [] Decode.string


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder (Maybe editor) Github.Object.PullRequestReviewComment
editor object =
    Object.selectionFieldDecoder "editor" [] object (identity >> Decode.maybe)


id : FieldDecoder String Github.Object.PullRequestReviewComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder (Maybe String) Github.Object.PullRequestReviewComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] (Decode.string |> Decode.maybe)


originalCommit : SelectionSet originalCommit Github.Object.Commit -> FieldDecoder (Maybe originalCommit) Github.Object.PullRequestReviewComment
originalCommit object =
    Object.selectionFieldDecoder "originalCommit" [] object (identity >> Decode.maybe)


originalPosition : FieldDecoder Int Github.Object.PullRequestReviewComment
originalPosition =
    Object.fieldDecoder "originalPosition" [] Decode.int


path : FieldDecoder String Github.Object.PullRequestReviewComment
path =
    Object.fieldDecoder "path" [] Decode.string


position : FieldDecoder (Maybe Int) Github.Object.PullRequestReviewComment
position =
    Object.fieldDecoder "position" [] (Decode.int |> Decode.maybe)


publishedAt : FieldDecoder (Maybe String) Github.Object.PullRequestReviewComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] (Decode.string |> Decode.maybe)


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.PullRequestReviewComment
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


pullRequestReview : SelectionSet pullRequestReview Github.Object.PullRequestReview -> FieldDecoder (Maybe pullRequestReview) Github.Object.PullRequestReviewComment
pullRequestReview object =
    Object.selectionFieldDecoder "pullRequestReview" [] object (identity >> Decode.maybe)


reactionGroups : SelectionSet reactionGroups Github.Object.ReactionGroup -> FieldDecoder (Maybe (List reactionGroups)) Github.Object.PullRequestReviewComment
reactionGroups object =
    Object.selectionFieldDecoder "reactionGroups" [] object (identity >> Decode.list >> Decode.maybe)


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Github.Object.ReactionConnection -> FieldDecoder reactions Github.Object.PullRequestReviewComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reactions" optionalArgs object identity


replyTo : SelectionSet replyTo Github.Object.PullRequestReviewComment -> FieldDecoder (Maybe replyTo) Github.Object.PullRequestReviewComment
replyTo object =
    Object.selectionFieldDecoder "replyTo" [] object (identity >> Decode.maybe)


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.PullRequestReviewComment
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


resourcePath : FieldDecoder String Github.Object.PullRequestReviewComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Github.Object.PullRequestReviewComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.PullRequestReviewComment
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Github.Object.PullRequestReviewComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Github.Object.PullRequestReviewComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.PullRequestReviewComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.PullRequestReviewComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.PullRequestReviewComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
