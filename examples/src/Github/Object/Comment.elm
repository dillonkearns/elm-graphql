module Github.Object.Comment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Comment
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.Comment
author object =
    Object.selectionFieldDecoder "author" [] object identity


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.Comment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.Comment
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.Comment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


createdAt : FieldDecoder String Github.Object.Comment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.Comment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.Comment
editor object =
    Object.selectionFieldDecoder "editor" [] object identity


id : FieldDecoder String Github.Object.Comment
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Github.Object.Comment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Github.Object.Comment
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


updatedAt : FieldDecoder String Github.Object.Comment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerDidAuthor : FieldDecoder Bool Github.Object.Comment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
