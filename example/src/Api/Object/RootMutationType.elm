module Api.Object.RootMutationType exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RootMutationType
build constructor =
    Object.object constructor


increment : FieldDecoder Int Api.Object.RootMutationType
increment =
    Object.fieldDecoder "increment" [] Decode.int
