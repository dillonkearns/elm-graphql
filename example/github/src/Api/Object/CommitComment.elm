module Api.Object.CommitComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.CommitComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.CommitComment
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.CommitComment
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.CommitComment
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.CommitComment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.CommitComment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.CommitComment
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.CommitComment
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.CommitComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.CommitComment
id =
    Field.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.CommitComment
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


path : FieldDecoder String Api.Object.CommitComment
path =
    Field.fieldDecoder "path" [] Decode.string


position : FieldDecoder Int Api.Object.CommitComment
position =
    Field.fieldDecoder "position" [] Decode.int


publishedAt : FieldDecoder String Api.Object.CommitComment
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.CommitComment
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.CommitComment
reactions object =
    Object.single "reactions" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.CommitComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.CommitComment
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.CommitComment
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.CommitComment
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.CommitComment
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Api.Object.CommitComment
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.CommitComment
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.CommitComment
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.CommitComment
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.bool
