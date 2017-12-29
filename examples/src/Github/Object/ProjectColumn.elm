module Github.Object.ProjectColumn exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProjectColumn
selection constructor =
    Object.object constructor


cards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet cards Github.Object.ProjectCardConnection -> FieldDecoder cards Github.Object.ProjectColumn
cards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "cards" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.ProjectColumn
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder (Maybe Int) Github.Object.ProjectColumn
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.ProjectColumn
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Github.Object.ProjectColumn
name =
    Object.fieldDecoder "name" [] Decode.string


project : SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.ProjectColumn
project object =
    Object.selectionFieldDecoder "project" [] object identity


resourcePath : FieldDecoder String Github.Object.ProjectColumn
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Github.Object.ProjectColumn
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.ProjectColumn
url =
    Object.fieldDecoder "url" [] Decode.string
