module Api.Object.GitActor exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GitActor
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.GitActor
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


date : FieldDecoder String Api.Object.GitActor
date =
    Field.fieldDecoder "date" [] Decode.string


email : FieldDecoder String Api.Object.GitActor
email =
    Field.fieldDecoder "email" [] Decode.string


name : FieldDecoder String Api.Object.GitActor
name =
    Field.fieldDecoder "name" [] Decode.string


user : Object user Api.Object.User -> FieldDecoder user Api.Object.GitActor
user object =
    Object.single "user" [] object
