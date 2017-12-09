module Api.Object.Node exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Node
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Node
id =
    Object.fieldDecoder "id" [] Decode.string
