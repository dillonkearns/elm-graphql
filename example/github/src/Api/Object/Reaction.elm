module Api.Object.Reaction exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.Reaction
selection constructor =
    Object.object constructor


content : FieldDecoder Api.Enum.ReactionContent.ReactionContent Api.Object.Reaction
content =
    Object.fieldDecoder "content" [] Api.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Api.Object.Reaction
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Reaction
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Reaction
id =
    Object.fieldDecoder "id" [] Decode.string


reactable : Object reactable Api.Object.Reactable -> FieldDecoder reactable Api.Object.Reaction
reactable object =
    Object.single "reactable" [] object


user : Object user Api.Object.User -> FieldDecoder user Api.Object.Reaction
user object =
    Object.single "user" [] object
