module Api.Object.Bot exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Bot
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.Bot
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


createdAt : FieldDecoder String Api.Object.Bot
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder String Api.Object.Bot
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.Bot
id =
    Field.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.Bot
login =
    Field.fieldDecoder "login" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Bot
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Bot
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Bot
url =
    Field.fieldDecoder "url" [] Decode.string
