module Api.Object.Reactable exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Reactable
selection constructor =
    Object.object constructor


databaseId : FieldDecoder Int Api.Object.Reactable
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Reactable
id =
    Object.fieldDecoder "id" [] Decode.string


reactionGroups : SelectionSet reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.Reactable
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Api.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Api.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.Reactable
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


viewerCanReact : FieldDecoder Bool Api.Object.Reactable
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool
