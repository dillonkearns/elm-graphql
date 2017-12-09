module Api.Object.Label exposing (..)

import Api.Enum.IssueState
import Api.Enum.PullRequestState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Label
build constructor =
    Object.object constructor


color : FieldDecoder String Api.Object.Label
color =
    Object.fieldDecoder "color" [] Decode.string


id : FieldDecoder String Api.Object.Label
id =
    Object.fieldDecoder "id" [] Decode.string


issues : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe String, states : Maybe (List Api.Enum.IssueState.IssueState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe String, states : Maybe (List Api.Enum.IssueState.IssueState) }) -> Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Label
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, labels = Nothing, orderBy = Nothing, states = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


name : FieldDecoder String Api.Object.Label
name =
    Object.fieldDecoder "name" [] Decode.string


pullRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe String }) -> Object pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.Label
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, labels = Nothing, headRefName = Nothing, baseRefName = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Label
repository object =
    Object.single "repository" [] object
