module Api.Object.UniformResourceLocatable exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UniformResourceLocatable
build constructor =
    Object.object constructor


resourcePath : FieldDecoder String Api.Object.UniformResourceLocatable
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.UniformResourceLocatable
url =
    Object.fieldDecoder "url" [] Decode.string
