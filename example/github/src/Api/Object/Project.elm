module Api.Object.Project exposing (..)

import Api.Enum.ProjectState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.Project
selection constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.Project
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Project
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


closed : FieldDecoder Bool Api.Object.Project
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Api.Object.Project
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


columns : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object columns Api.Object.ProjectColumnConnection -> FieldDecoder columns Api.Object.Project
columns fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "columns" optionalArgs object


createdAt : FieldDecoder String Api.Object.Project
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Project
creator object =
    Object.single "creator" [] object


databaseId : FieldDecoder Int Api.Object.Project
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Project
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Project
name =
    Object.fieldDecoder "name" [] Decode.string


number : FieldDecoder Int Api.Object.Project
number =
    Object.fieldDecoder "number" [] Decode.int


owner : Object owner Api.Object.ProjectOwner -> FieldDecoder owner Api.Object.Project
owner object =
    Object.single "owner" [] object


pendingCards : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object pendingCards Api.Object.ProjectCardConnection -> FieldDecoder pendingCards Api.Object.Project
pendingCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "pendingCards" optionalArgs object


resourcePath : FieldDecoder String Api.Object.Project
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.ProjectState.ProjectState Api.Object.Project
state =
    Object.fieldDecoder "state" [] Api.Enum.ProjectState.decoder


updatedAt : FieldDecoder String Api.Object.Project
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Project
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanUpdate : FieldDecoder Bool Api.Object.Project
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool
