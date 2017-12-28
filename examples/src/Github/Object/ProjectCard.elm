module Github.Object.ProjectCard exposing (..)

import Github.Enum.ProjectCardState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProjectCard
selection constructor =
    Object.object constructor


column : SelectionSet column Github.Object.ProjectColumn -> FieldDecoder column Github.Object.ProjectCard
column object =
    Object.selectionFieldDecoder "column" [] object identity


content : FieldDecoder String Github.Object.ProjectCard
content =
    Object.fieldDecoder "content" [] Decode.string


createdAt : FieldDecoder String Github.Object.ProjectCard
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.ProjectCard
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


databaseId : FieldDecoder Int Github.Object.ProjectCard
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Github.Object.ProjectCard
id =
    Object.fieldDecoder "id" [] Decode.string


note : FieldDecoder String Github.Object.ProjectCard
note =
    Object.fieldDecoder "note" [] Decode.string


project : SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.ProjectCard
project object =
    Object.selectionFieldDecoder "project" [] object identity


projectColumn : SelectionSet projectColumn Github.Object.ProjectColumn -> FieldDecoder projectColumn Github.Object.ProjectCard
projectColumn object =
    Object.selectionFieldDecoder "projectColumn" [] object identity


resourcePath : FieldDecoder String Github.Object.ProjectCard
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Github.Enum.ProjectCardState.ProjectCardState Github.Object.ProjectCard
state =
    Object.fieldDecoder "state" [] Github.Enum.ProjectCardState.decoder


updatedAt : FieldDecoder String Github.Object.ProjectCard
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.ProjectCard
url =
    Object.fieldDecoder "url" [] Decode.string
