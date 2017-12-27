module Github.Object.GistComment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.GistComment
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.GistComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.GistComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.GistComment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.GistComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Github.Object.GistComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.GistComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.GistComment
editor object =
    Object.single "editor" [] object


gist : SelectionSet gist Github.Object.Gist -> FieldDecoder gist Github.Object.GistComment
gist object =
    Object.single "gist" [] object


id : FieldDecoder String Github.Object.GistComment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Github.Object.GistComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Github.Object.GistComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Github.Object.GistComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerCanDelete : FieldDecoder Bool Github.Object.GistComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.GistComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.GistComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.GistComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
