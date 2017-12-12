module Api.Object.GistComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.GistComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.GistComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.GistComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.GistComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Api.Object.GistComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.GistComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.GistComment
editor object =
    Object.single "editor" [] object


gist : Object gist Api.Object.Gist -> FieldDecoder gist Api.Object.GistComment
gist object =
    Object.single "gist" [] object


id : FieldDecoder String Api.Object.GistComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.GistComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.GistComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.GistComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.GistComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.GistComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.GistComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.GistComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
