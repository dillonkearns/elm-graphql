module Api.Object.MenuItem exposing (..)

import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor


description : FieldDecoder String Type
description =
    Field.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Type
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Type
name =
    Field.fieldDecoder "name" [] Decode.string
