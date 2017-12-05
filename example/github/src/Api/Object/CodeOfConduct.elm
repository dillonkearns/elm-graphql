module Api.Object.CodeOfConduct exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CodeOfConduct
build constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.CodeOfConduct
body =
    Field.fieldDecoder "body" [] Decode.string


key : FieldDecoder String Api.Object.CodeOfConduct
key =
    Field.fieldDecoder "key" [] Decode.string


name : FieldDecoder String Api.Object.CodeOfConduct
name =
    Field.fieldDecoder "name" [] Decode.string


url : FieldDecoder String Api.Object.CodeOfConduct
url =
    Field.fieldDecoder "url" [] Decode.string
