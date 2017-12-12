module Api.Object.ProjectColumn exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectColumn
build constructor =
    Object.object constructor


cards : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object cards Api.Object.ProjectCardConnection -> FieldDecoder cards Api.Object.ProjectColumn
cards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "cards" optionalArgs object


createdAt : FieldDecoder String Api.Object.ProjectColumn
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.ProjectColumn
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ProjectColumn
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.ProjectColumn
name =
    Object.fieldDecoder "name" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.ProjectColumn
project object =
    Object.single "project" [] object


resourcePath : FieldDecoder String Api.Object.ProjectColumn
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.ProjectColumn
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.ProjectColumn
url =
    Object.fieldDecoder "url" [] Decode.string
