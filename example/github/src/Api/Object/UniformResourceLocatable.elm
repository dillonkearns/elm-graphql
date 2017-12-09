module Api.Object.UniformResourceLocatable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UniformResourceLocatable
build constructor =
    Object.object constructor


resourcePath : FieldDecoder String Api.Object.UniformResourceLocatable
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.UniformResourceLocatable
url =
    Object.fieldDecoder "url" [] Decode.string
