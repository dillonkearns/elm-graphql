module Api.Object.CommitComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.CommitComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.CommitComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.CommitComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.CommitComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.CommitComment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.CommitComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.CommitComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.CommitComment
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.CommitComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.CommitComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.CommitComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


path : FieldDecoder String Api.Object.CommitComment
path =
    Object.fieldDecoder "path" [] Decode.string


position : FieldDecoder Int Api.Object.CommitComment
position =
    Object.fieldDecoder "position" [] Decode.int


publishedAt : FieldDecoder String Api.Object.CommitComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.CommitComment
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe String }) -> Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.CommitComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, content = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optionalEnum "content" filledInOptionals.content, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.CommitComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.CommitComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.CommitComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.CommitComment
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.CommitComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Api.Object.CommitComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.CommitComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.CommitComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.CommitComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
