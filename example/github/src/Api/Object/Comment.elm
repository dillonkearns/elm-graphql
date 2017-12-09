module Api.Object.Comment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Comment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.Comment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.Comment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.Comment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Comment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Api.Object.Comment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.Comment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.Comment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.Comment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.Comment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.Comment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Comment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerDidAuthor : FieldDecoder Bool Api.Object.Comment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
