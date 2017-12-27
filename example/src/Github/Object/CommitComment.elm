module Github.Object.CommitComment exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitComment
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.CommitComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.CommitComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.CommitComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.CommitComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.CommitComment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Github.Object.CommitComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.CommitComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Github.Object.CommitComment
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.CommitComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Github.Object.CommitComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Github.Object.CommitComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


path : FieldDecoder String Github.Object.CommitComment
path =
    Object.fieldDecoder "path" [] Decode.string


position : FieldDecoder Int Github.Object.CommitComment
position =
    Object.fieldDecoder "position" [] Decode.int


publishedAt : FieldDecoder String Github.Object.CommitComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : SelectionSet reactionGroups Github.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Github.Object.CommitComment
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Github.Object.ReactionConnection -> FieldDecoder reactions Github.Object.CommitComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.CommitComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Github.Object.CommitComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Github.Object.CommitComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.CommitComment
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Github.Object.CommitComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Github.Object.CommitComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.CommitComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.CommitComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.CommitComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
