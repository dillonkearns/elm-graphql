module Api.Object.GistComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.GistComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.GistComment
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.GistComment
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.GistComment
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Api.Object.GistComment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder String Api.Object.GistComment
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.GistComment
editor object =
    Object.single "editor" [] object


gist : Object gist Api.Object.Gist -> FieldDecoder gist Api.Object.GistComment
gist object =
    Object.single "gist" [] object


id : FieldDecoder String Api.Object.GistComment
id =
    Field.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.GistComment
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.GistComment
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.GistComment
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


viewerCanDelete : FieldDecoder String Api.Object.GistComment
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.string


viewerCanUpdate : FieldDecoder String Api.Object.GistComment
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.string


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.GistComment
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder String Api.Object.GistComment
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.string
