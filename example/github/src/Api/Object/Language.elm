module Api.Object.Language exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Language
build constructor =
    Object.object constructor


color : FieldDecoder String Api.Object.Language
color =
    Object.fieldDecoder "color" [] Decode.string


id : FieldDecoder String Api.Object.Language
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Language
name =
    Object.fieldDecoder "name" [] Decode.string
