module Api.Object.Milestone exposing (..)

import Api.Enum.MilestoneState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Milestone
build constructor =
    Object.object constructor


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Milestone
creator object =
    Object.single "creator" [] object


description : FieldDecoder String Api.Object.Milestone
description =
    Field.fieldDecoder "description" [] Decode.string


dueOn : FieldDecoder String Api.Object.Milestone
dueOn =
    Field.fieldDecoder "dueOn" [] Decode.string


id : FieldDecoder String Api.Object.Milestone
id =
    Field.fieldDecoder "id" [] Decode.string


issues : Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Milestone
issues object =
    Object.single "issues" [] object


number : FieldDecoder String Api.Object.Milestone
number =
    Field.fieldDecoder "number" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Milestone
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Milestone
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.MilestoneState.MilestoneState Api.Object.Milestone
state =
    Field.fieldDecoder "state" [] Api.Enum.MilestoneState.decoder


title : FieldDecoder String Api.Object.Milestone
title =
    Field.fieldDecoder "title" [] Decode.string


url : FieldDecoder String Api.Object.Milestone
url =
    Field.fieldDecoder "url" [] Decode.string
