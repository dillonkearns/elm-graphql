module Api.Object.Ref exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Ref
build constructor =
    Object.object constructor


associatedPullRequests : Object associatedPullRequests Api.Object.PullRequestConnection -> FieldDecoder associatedPullRequests Api.Object.Ref
associatedPullRequests object =
    Object.single "associatedPullRequests" [] object


id : FieldDecoder String Api.Object.Ref
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Ref
name =
    Field.fieldDecoder "name" [] Decode.string


prefix : FieldDecoder String Api.Object.Ref
prefix =
    Field.fieldDecoder "prefix" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Ref
repository object =
    Object.single "repository" [] object


target : Object target Api.Object.GitObject -> FieldDecoder target Api.Object.Ref
target object =
    Object.single "target" [] object
