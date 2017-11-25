module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Schema.MenuItem as MenuItem


menuItems : List (TypeLocked Argument typeLock) -> Object menuItem typeLock -> Field.RootQuery (List menuItem)
menuItems optionalArgs object =
    Object.listOf "menuItems" optionalArgs object
        |> Field.rootQuery


menuItem : { id : String } -> List (TypeLocked Argument MenuItem.Type) -> Object menuItem MenuItem.Type -> Field.RootQuery menuItem
menuItem requiredArgs optionalArgs object =
    Object.single "menuItem" (MenuItem.idArg requiredArgs.id :: optionalArgs) object
        |> Field.rootQuery
