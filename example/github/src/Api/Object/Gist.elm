module Api.Object.Gist exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Gist
build constructor =
    Object.object constructor


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object comments Api.Object.GistCommentConnection -> FieldDecoder comments Api.Object.Gist
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


createdAt : FieldDecoder String Api.Object.Gist
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Gist
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.Gist
id =
    Object.fieldDecoder "id" [] Decode.string


isPublic : FieldDecoder Bool Api.Object.Gist
isPublic =
    Object.fieldDecoder "isPublic" [] Decode.bool


name : FieldDecoder String Api.Object.Gist
name =
    Object.fieldDecoder "name" [] Decode.string


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.Gist
owner object =
    Object.single "owner" [] object


pushedAt : FieldDecoder String Api.Object.Gist
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


stargazers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String }) -> Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Gist
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "stargazers" optionalArgs object


updatedAt : FieldDecoder String Api.Object.Gist
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerHasStarred : FieldDecoder Bool Api.Object.Gist
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool
