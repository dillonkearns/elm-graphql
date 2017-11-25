module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import Schema.MenuItem as MenuItem


menuItems : List Argument -> Object menuItem kind -> Field.RootQuery (List menuItem)
menuItems optionalArgs object =
    Object.listOf "menuItems" optionalArgs object
        |> Field.rootQuery


menuItem : { id : String } -> List Argument -> Object menuItem kind -> Field.RootQuery menuItem
menuItem requiredArgs optionalArgs object =
    Object.single "menuItem" (MenuItem.idArg requiredArgs.id :: optionalArgs) object
        |> Field.rootQuery
