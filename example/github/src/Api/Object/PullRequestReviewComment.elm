module Api.Object.PullRequestReviewComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PullRequestReviewComment
selection constructor =
    Object.object constructor


author : SelectionSet author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequestReviewComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequestReviewComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.PullRequestReviewComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequestReviewComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequestReviewComment
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestReviewComment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.PullRequestReviewComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequestReviewComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequestReviewComment
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


diffHunk : FieldDecoder String Api.Object.PullRequestReviewComment
diffHunk =
    Object.fieldDecoder "diffHunk" [] Decode.string


draftedAt : FieldDecoder String Api.Object.PullRequestReviewComment
draftedAt =
    Object.fieldDecoder "draftedAt" [] Decode.string


editor : SelectionSet editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequestReviewComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.PullRequestReviewComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.PullRequestReviewComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


originalCommit : SelectionSet originalCommit Api.Object.Commit -> FieldDecoder originalCommit Api.Object.PullRequestReviewComment
originalCommit object =
    Object.single "originalCommit" [] object


originalPosition : FieldDecoder Int Api.Object.PullRequestReviewComment
originalPosition =
    Object.fieldDecoder "originalPosition" [] Decode.int


path : FieldDecoder String Api.Object.PullRequestReviewComment
path =
    Object.fieldDecoder "path" [] Decode.string


position : FieldDecoder Int Api.Object.PullRequestReviewComment
position =
    Object.fieldDecoder "position" [] Decode.int


publishedAt : FieldDecoder String Api.Object.PullRequestReviewComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReviewComment
pullRequest object =
    Object.single "pullRequest" [] object


pullRequestReview : SelectionSet pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.PullRequestReviewComment
pullRequestReview object =
    Object.single "pullRequestReview" [] object


reactionGroups : SelectionSet reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.PullRequestReviewComment
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value }) -> SelectionSet reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.PullRequestReviewComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, content = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


replyTo : SelectionSet replyTo Api.Object.PullRequestReviewComment -> FieldDecoder replyTo Api.Object.PullRequestReviewComment
replyTo object =
    Object.single "replyTo" [] object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReviewComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestReviewComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequestReviewComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestReviewComment
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.PullRequestReviewComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Api.Object.PullRequestReviewComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequestReviewComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequestReviewComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequestReviewComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
