module Schema.MenuItem exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)


menuItem : (a -> constructor) -> Object (a -> constructor)
menuItem constructor =
    Object.object constructor


id : FieldDecoder String
id =
    Field.string "id"


name : FieldDecoder String
name =
    Field.string "name"


contains : String -> Argument
contains =
    Argument.string "contains"


idArg : String -> Argument
idArg =
    Argument.string "id"
