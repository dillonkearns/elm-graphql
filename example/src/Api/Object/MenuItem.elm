module Api.Object.MenuItem exposing (..)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor


description : TypeLocked (FieldDecoder String) Type
description =
    Field.fieldDecoder "name" Decode.string


id : TypeLocked (FieldDecoder String) Type
id =
    Field.fieldDecoder "name" Decode.string


name : TypeLocked (FieldDecoder String) Type
name =
    Field.fieldDecoder "name" Decode.string
