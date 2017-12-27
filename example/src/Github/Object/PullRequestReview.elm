module Github.Object.PullRequestReview exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.PullRequestReviewState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequestReview
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.PullRequestReview
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.PullRequestReview
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.PullRequestReview
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.PullRequestReview
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Github.Object.PullRequestReview
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Github.Object.PullRequestReview
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.PullRequestReview
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Github.Object.PullRequestReview
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.PullRequestReview
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Github.Object.PullRequestReview
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.PullRequestReview
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Github.Object.PullRequestReview
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Github.Object.PullRequestReview
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Github.Object.PullRequestReview
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.PullRequestReview
pullRequest object =
    Object.single "pullRequest" [] object


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.PullRequestReview
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Github.Object.PullRequestReview
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Github.Enum.PullRequestReviewState.PullRequestReviewState Github.Object.PullRequestReview
state =
    Object.fieldDecoder "state" [] Github.Enum.PullRequestReviewState.decoder


submittedAt : FieldDecoder String Github.Object.PullRequestReview
submittedAt =
    Object.fieldDecoder "submittedAt" [] Decode.string


updatedAt : FieldDecoder String Github.Object.PullRequestReview
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.PullRequestReview
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Github.Object.PullRequestReview
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.PullRequestReview
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.PullRequestReview
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.PullRequestReview
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
