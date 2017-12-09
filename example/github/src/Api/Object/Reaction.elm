module Api.Object.Reaction exposing (..)

import Api.Enum.ReactionContent
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Reaction
build constructor =
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
