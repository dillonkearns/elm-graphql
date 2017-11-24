module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)


menuItems : List Argument -> FieldDecoder menuItem -> Field.RootQuery (List menuItem)
menuItems optionalArgs fieldDecoder =
    Field.listAt "menuItems" fieldDecoder
        |> Field.rootQuery
