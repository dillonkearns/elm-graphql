module Api.Object.Gist exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Gist
build constructor =
    Object.object constructor


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object comments Api.Object.GistCommentConnection -> FieldDecoder comments Api.Object.Gist
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
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


stargazers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value }) -> Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Gist
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "stargazers" optionalArgs object


updatedAt : FieldDecoder String Api.Object.Gist
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerHasStarred : FieldDecoder Bool Api.Object.Gist
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool
