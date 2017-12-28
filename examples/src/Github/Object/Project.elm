module Github.Object.Project exposing (..)

import Github.Enum.ProjectState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Project
selection constructor =
    Object.object constructor


body : FieldDecoder String Github.Object.Project
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.Project
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


closed : FieldDecoder Bool Github.Object.Project
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Github.Object.Project
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


columns : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet columns Github.Object.ProjectColumnConnection -> FieldDecoder columns Github.Object.Project
columns fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "columns" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.Project
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.Project
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


databaseId : FieldDecoder Int Github.Object.Project
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Github.Object.Project
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Github.Object.Project
name =
    Object.fieldDecoder "name" [] Decode.string


number : FieldDecoder Int Github.Object.Project
number =
    Object.fieldDecoder "number" [] Decode.int


owner : SelectionSet owner Github.Object.ProjectOwner -> FieldDecoder owner Github.Object.Project
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


pendingCards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet pendingCards Github.Object.ProjectCardConnection -> FieldDecoder pendingCards Github.Object.Project
pendingCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pendingCards" optionalArgs object identity


resourcePath : FieldDecoder String Github.Object.Project
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Github.Enum.ProjectState.ProjectState Github.Object.Project
state =
    Object.fieldDecoder "state" [] Github.Enum.ProjectState.decoder


updatedAt : FieldDecoder String Github.Object.Project
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Project
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanUpdate : FieldDecoder Bool Github.Object.Project
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool
