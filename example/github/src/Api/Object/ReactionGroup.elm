module Api.Object.ReactionGroup exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReactionGroup
selection constructor =
    Object.object constructor


content : FieldDecoder Api.Enum.ReactionContent.ReactionContent Api.Object.ReactionGroup
content =
    Object.fieldDecoder "content" [] Api.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Api.Object.ReactionGroup
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


subject : SelectionSet subject Api.Object.Reactable -> FieldDecoder subject Api.Object.ReactionGroup
subject object =
    Object.single "subject" [] object


users : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet users Api.Object.ReactingUserConnection -> FieldDecoder users Api.Object.ReactionGroup
users fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "users" optionalArgs object


viewerHasReacted : FieldDecoder Bool Api.Object.ReactionGroup
viewerHasReacted =
    Object.fieldDecoder "viewerHasReacted" [] Decode.bool
