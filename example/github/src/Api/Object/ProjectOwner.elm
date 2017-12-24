module Api.Object.ProjectOwner exposing (..)

import Api.Enum.ProjectState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectOwner
selection constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.ProjectOwner
id =
    Object.fieldDecoder "id" [] Decode.string


project : { number : String } -> Object project Api.Object.Project -> FieldDecoder project Api.Object.ProjectOwner
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) }) -> Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.ProjectOwner
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing, search = Nothing, states = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Api.Object.ProjectOwner
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.ProjectOwner
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


viewerCanCreateProjects : FieldDecoder Bool Api.Object.ProjectOwner
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool
