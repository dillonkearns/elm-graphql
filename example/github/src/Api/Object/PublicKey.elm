module Api.Object.PublicKey exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKey
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.PublicKey
id =
    Object.fieldDecoder "id" [] Decode.string


key : FieldDecoder String Api.Object.PublicKey
key =
    Object.fieldDecoder "key" [] Decode.string
