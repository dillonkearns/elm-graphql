module Api.Object.PullRequestReview exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.CommentCannotUpdateReason
import Api.Enum.PullRequestReviewState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PullRequestReview
selection constructor =
    Object.object constructor


author : SelectionSet author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequestReview
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequestReview
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.PullRequestReview
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequestReview
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequestReview
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Api.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Api.Object.PullRequestReview
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestReview
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.PullRequestReview
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequestReview
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequestReview
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : SelectionSet editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequestReview
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.PullRequestReview
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.PullRequestReview
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.PullRequestReview
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReview
pullRequest object =
    Object.single "pullRequest" [] object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReview
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestReview
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.PullRequestReviewState.PullRequestReviewState Api.Object.PullRequestReview
state =
    Object.fieldDecoder "state" [] Api.Enum.PullRequestReviewState.decoder


submittedAt : FieldDecoder String Api.Object.PullRequestReview
submittedAt =
    Object.fieldDecoder "submittedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequestReview
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestReview
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Api.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Api.Object.PullRequestReview
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Api.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequestReview
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
