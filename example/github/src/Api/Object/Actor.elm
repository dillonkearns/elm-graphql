module Api.Object.Actor exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Actor
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.Actor
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


login : FieldDecoder String Api.Object.Actor
login =
    Field.fieldDecoder "login" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Actor
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.Actor
url =
    Field.fieldDecoder "url" [] Decode.string
