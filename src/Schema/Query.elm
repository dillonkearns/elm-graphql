module Schema.Query exposing (..)

-- import GraphqElm.Argument as Argument exposing (Argument)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)


menuItems : FieldDecoder menuItem -> Field.RootQuery (List menuItem)
menuItems fieldDecoder =
    Field.listAt [ "data", "menuItems" ] fieldDecoder
        |> Field.rootQuery
