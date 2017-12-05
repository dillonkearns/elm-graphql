module Api.Object.Comment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Comment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.Comment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.Comment
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.Comment
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Comment
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Api.Object.Comment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder String Api.Object.Comment
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.Comment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.Comment
id =
    Field.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.Comment
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.Comment
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Comment
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


viewerDidAuthor : FieldDecoder String Api.Object.Comment
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.string
