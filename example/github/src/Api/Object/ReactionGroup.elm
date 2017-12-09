module Api.Object.ReactionGroup exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactionGroup
build constructor =
    Object.object constructor


content : FieldDecoder Api.Enum.ReactionContent.ReactionContent Api.Object.ReactionGroup
content =
    Object.fieldDecoder "content" [] Api.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Api.Object.ReactionGroup
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


subject : Object subject Api.Object.Reactable -> FieldDecoder subject Api.Object.ReactionGroup
subject object =
    Object.single "subject" [] object


users : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object users Api.Object.ReactingUserConnection -> FieldDecoder users Api.Object.ReactionGroup
users fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "users" optionalArgs object


viewerHasReacted : FieldDecoder Bool Api.Object.ReactionGroup
viewerHasReacted =
    Object.fieldDecoder "viewerHasReacted" [] Decode.bool
