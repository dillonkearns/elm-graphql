module Api.Object.Label exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Label
build constructor =
    Object.object constructor


color : FieldDecoder String Api.Object.Label
color =
    Field.fieldDecoder "color" [] Decode.string


id : FieldDecoder String Api.Object.Label
id =
    Field.fieldDecoder "id" [] Decode.string


issues : Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Label
issues object =
    Object.single "issues" [] object


name : FieldDecoder String Api.Object.Label
name =
    Field.fieldDecoder "name" [] Decode.string


pullRequests : Object pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.Label
pullRequests object =
    Object.single "pullRequests" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Label
repository object =
    Object.single "repository" [] object
