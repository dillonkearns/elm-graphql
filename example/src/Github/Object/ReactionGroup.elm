module Github.Object.ReactionGroup exposing (..)

import Github.Enum.ReactionContent
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReactionGroup
selection constructor =
    Object.object constructor


content : FieldDecoder Github.Enum.ReactionContent.ReactionContent Github.Object.ReactionGroup
content =
    Object.fieldDecoder "content" [] Github.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Github.Object.ReactionGroup
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


subject : SelectionSet subject Github.Object.Reactable -> FieldDecoder subject Github.Object.ReactionGroup
subject object =
    Object.single "subject" [] object


users : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet users Github.Object.ReactingUserConnection -> FieldDecoder users Github.Object.ReactionGroup
users fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "users" optionalArgs object


viewerHasReacted : FieldDecoder Bool Github.Object.ReactionGroup
viewerHasReacted =
    Object.fieldDecoder "viewerHasReacted" [] Decode.bool
