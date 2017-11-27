module Schema.MenuItem exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor


id : TypeLocked (FieldDecoder String) Type
id =
    Field.fieldDecoder "id" Decode.string


name : TypeLocked (FieldDecoder String) Type
name =
    Field.fieldDecoder "name" Decode.string


contains : String -> TypeLocked Argument Type
contains value =
    Argument.string "contains" value


idArg : String -> TypeLocked Argument Type
idArg value =
    Argument.string "id" value
