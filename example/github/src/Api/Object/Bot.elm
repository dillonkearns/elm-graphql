module Api.Object.Bot exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Bot
build constructor =
    Object.object constructor


avatarUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.Bot
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


createdAt : FieldDecoder String Api.Object.Bot
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Bot
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Bot
id =
    Object.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.Bot
login =
    Object.fieldDecoder "login" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Bot
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Bot
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Bot
url =
    Object.fieldDecoder "url" [] Decode.string
