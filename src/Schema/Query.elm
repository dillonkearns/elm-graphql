module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)


menuItems : List Argument -> Object menuItem -> Field.RootQuery (List menuItem)
menuItems optionalArgs object =
    -- Field.listAt "menuItems" fieldDecoder
    Object.listOf "menuItems" optionalArgs object
        |> Field.rootQuery
