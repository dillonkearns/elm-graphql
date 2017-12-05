module Api.Object.PublicKey exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKey
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.PublicKey
id =
    Field.fieldDecoder "id" [] Decode.string


key : FieldDecoder String Api.Object.PublicKey
key =
    Field.fieldDecoder "key" [] Decode.string
