module Api.Object.CodeOfConduct exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CodeOfConduct
build constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.CodeOfConduct
body =
    Object.fieldDecoder "body" [] Decode.string


key : FieldDecoder String Api.Object.CodeOfConduct
key =
    Object.fieldDecoder "key" [] Decode.string


name : FieldDecoder String Api.Object.CodeOfConduct
name =
    Object.fieldDecoder "name" [] Decode.string


url : FieldDecoder String Api.Object.CodeOfConduct
url =
    Object.fieldDecoder "url" [] Decode.string
