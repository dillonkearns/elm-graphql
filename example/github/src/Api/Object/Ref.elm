module Api.Object.Ref exposing (..)

import Api.Enum.PullRequestState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Ref
build constructor =
    Object.object constructor


associatedPullRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value }) -> Object associatedPullRequests Api.Object.PullRequestConnection -> FieldDecoder associatedPullRequests Api.Object.Ref
associatedPullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, labels = Nothing, headRefName = Nothing, baseRefName = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "states" filledInOptionals.states (Value.enum toString |> Value.list), Argument.optional "labels" filledInOptionals.labels (Value.string |> Value.list), Argument.optional "headRefName" filledInOptionals.headRefName Value.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "associatedPullRequests" optionalArgs object


id : FieldDecoder String Api.Object.Ref
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Ref
name =
    Object.fieldDecoder "name" [] Decode.string


prefix : FieldDecoder String Api.Object.Ref
prefix =
    Object.fieldDecoder "prefix" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Ref
repository object =
    Object.single "repository" [] object


target : Object target Api.Object.GitObject -> FieldDecoder target Api.Object.Ref
target object =
    Object.single "target" [] object
