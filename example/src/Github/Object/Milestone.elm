module Github.Object.Milestone exposing (..)

import Github.Enum.IssueState
import Github.Enum.MilestoneState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Milestone
selection constructor =
    Object.object constructor


closed : FieldDecoder Bool Github.Object.Milestone
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Github.Object.Milestone
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


createdAt : FieldDecoder String Github.Object.Milestone
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.Milestone
creator object =
    Object.single "creator" [] object


description : FieldDecoder String Github.Object.Milestone
description =
    Object.fieldDecoder "description" [] Decode.string


dueOn : FieldDecoder String Github.Object.Milestone
dueOn =
    Object.fieldDecoder "dueOn" [] Decode.string


id : FieldDecoder String Github.Object.Milestone
id =
    Object.fieldDecoder "id" [] Decode.string


issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) }) -> SelectionSet issues Github.Object.IssueConnection -> FieldDecoder issues Github.Object.Milestone
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


number : FieldDecoder Int Github.Object.Milestone
number =
    Object.fieldDecoder "number" [] Decode.int


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Milestone
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Github.Object.Milestone
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Github.Enum.MilestoneState.MilestoneState Github.Object.Milestone
state =
    Object.fieldDecoder "state" [] Github.Enum.MilestoneState.decoder


title : FieldDecoder String Github.Object.Milestone
title =
    Object.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Github.Object.Milestone
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Milestone
url =
    Object.fieldDecoder "url" [] Decode.string
