module Api.Object.MenuItem exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MenuItem
build constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.MenuItem
description =
    Field.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.MenuItem
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.MenuItem
name =
    Field.fieldDecoder "name" [] Decode.string
