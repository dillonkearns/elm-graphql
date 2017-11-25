module Schema.MenuItem exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))


type Kind
    = Kind


menuItem : (a -> constructor) -> Object (a -> constructor) Kind
menuItem constructor =
    Object.object constructor


id : TypeLocked (FieldDecoder String) Kind
id =
    Field.string "id"


name : TypeLocked (FieldDecoder String) Kind
name =
    Field.string "name"


contains : String -> TypeLocked Argument Kind
contains value =
    Argument.string "contains" value
        |> TypeLocked


idArg : String -> TypeLocked Argument Kind
idArg value =
    Argument.string "id" value
        |> TypeLocked
