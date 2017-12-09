module Api.Object.Reactable exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Reactable
build constructor =
    Object.object constructor


databaseId : FieldDecoder Int Api.Object.Reactable
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Reactable
id =
    Object.fieldDecoder "id" [] Decode.string


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.Reactable
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe String }) -> Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.Reactable
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, content = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optionalEnum "content" filledInOptionals.content, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


viewerCanReact : FieldDecoder Bool Api.Object.Reactable
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool
