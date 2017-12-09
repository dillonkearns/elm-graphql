module Api.Object.Ref exposing (..)

import Api.Enum.PullRequestState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Ref
build constructor =
    Object.object constructor


associatedPullRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe String }) -> Object associatedPullRequests Api.Object.PullRequestConnection -> FieldDecoder associatedPullRequests Api.Object.Ref
associatedPullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, labels = Nothing, headRefName = Nothing, baseRefName = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Api.Enum.PullRequestState.decoder |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
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
