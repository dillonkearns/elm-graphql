module Api.Object.CodeOfConduct exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


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
