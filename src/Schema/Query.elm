module Schema.Query exposing (..)

-- import GraphqElm.Argument as Argument exposing (Argument)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)


menuItem : (a -> constructor) -> FieldDecoder (a -> constructor)
menuItem constructor =
    Field.object
        constructor
        "menuItems"
        []



-- how to decode a MenuItem


menuItems : FieldDecoder menuItem -> FieldDecoder (List menuItem)
menuItems fieldDecoder =
    Field.listAt [ "data", "menuItems" ] fieldDecoder
