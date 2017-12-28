module Github.Object.Gist exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Gist
selection constructor =
    Object.object constructor


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.GistCommentConnection -> FieldDecoder comments Github.Object.Gist
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.Gist
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Github.Object.Gist
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Github.Object.Gist
id =
    Object.fieldDecoder "id" [] Decode.string


isPublic : FieldDecoder Bool Github.Object.Gist
isPublic =
    Object.fieldDecoder "isPublic" [] Decode.bool


name : FieldDecoder String Github.Object.Gist
name =
    Object.fieldDecoder "name" [] Decode.string


owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder owner Github.Object.Gist
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


pushedAt : FieldDecoder String Github.Object.Gist
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


stargazers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet stargazers Github.Object.StargazerConnection -> FieldDecoder stargazers Github.Object.Gist
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "stargazers" optionalArgs object identity


updatedAt : FieldDecoder String Github.Object.Gist
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


viewerHasStarred : FieldDecoder Bool Github.Object.Gist
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool
