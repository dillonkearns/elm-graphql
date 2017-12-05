module Api.Object.ReactionGroup exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactionGroup
build constructor =
    Object.object constructor


content : FieldDecoder Api.Enum.ReactionContent.ReactionContent Api.Object.ReactionGroup
content =
    Field.fieldDecoder "content" [] Api.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Api.Object.ReactionGroup
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


subject : Object subject Api.Object.Reactable -> FieldDecoder subject Api.Object.ReactionGroup
subject object =
    Object.single "subject" [] object


users : Object users Api.Object.ReactingUserConnection -> FieldDecoder users Api.Object.ReactionGroup
users object =
    Object.single "users" [] object


viewerHasReacted : FieldDecoder String Api.Object.ReactionGroup
viewerHasReacted =
    Field.fieldDecoder "viewerHasReacted" [] Decode.string
