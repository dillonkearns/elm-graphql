module Api.Object.UniformResourceLocatable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UniformResourceLocatable
build constructor =
    Object.object constructor


resourcePath : FieldDecoder String Api.Object.UniformResourceLocatable
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.UniformResourceLocatable
url =
    Field.fieldDecoder "url" [] Decode.string
