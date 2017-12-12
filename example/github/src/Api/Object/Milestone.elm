module Api.Object.Milestone exposing (..)

import Api.Enum.IssueState
import Api.Enum.MilestoneState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Milestone
build constructor =
    Object.object constructor


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Milestone
creator object =
    Object.single "creator" [] object


description : FieldDecoder String Api.Object.Milestone
description =
    Object.fieldDecoder "description" [] Decode.string


dueOn : FieldDecoder String Api.Object.Milestone
dueOn =
    Object.fieldDecoder "dueOn" [] Decode.string


id : FieldDecoder String Api.Object.Milestone
id =
    Object.fieldDecoder "id" [] Decode.string


issues : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) }) -> Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Milestone
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, labels = Nothing, orderBy = Nothing, states = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


number : FieldDecoder Int Api.Object.Milestone
number =
    Object.fieldDecoder "number" [] Decode.int


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Milestone
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Milestone
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.MilestoneState.MilestoneState Api.Object.Milestone
state =
    Object.fieldDecoder "state" [] Api.Enum.MilestoneState.decoder


title : FieldDecoder String Api.Object.Milestone
title =
    Object.fieldDecoder "title" [] Decode.string


url : FieldDecoder String Api.Object.Milestone
url =
    Object.fieldDecoder "url" [] Decode.string
