module Api.Object.Gist exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Gist
build constructor =
    Object.object constructor


comments : Object comments Api.Object.GistCommentConnection -> FieldDecoder comments Api.Object.Gist
comments object =
    Object.single "comments" [] object


createdAt : FieldDecoder String Api.Object.Gist
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Gist
description =
    Field.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.Gist
id =
    Field.fieldDecoder "id" [] Decode.string


isPublic : FieldDecoder Bool Api.Object.Gist
isPublic =
    Field.fieldDecoder "isPublic" [] Decode.bool


name : FieldDecoder String Api.Object.Gist
name =
    Field.fieldDecoder "name" [] Decode.string


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.Gist
owner object =
    Object.single "owner" [] object


pushedAt : FieldDecoder String Api.Object.Gist
pushedAt =
    Field.fieldDecoder "pushedAt" [] Decode.string


stargazers : Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Gist
stargazers object =
    Object.single "stargazers" [] object


updatedAt : FieldDecoder String Api.Object.Gist
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


viewerHasStarred : FieldDecoder Bool Api.Object.Gist
viewerHasStarred =
    Field.fieldDecoder "viewerHasStarred" [] Decode.bool
