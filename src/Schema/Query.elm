module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query as Query
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)
import Schema.MenuItem as MenuItem


menuItems : List (TypeLocked Argument typeLock) -> Object menuItem typeLock -> Field.Query (List menuItem)
menuItems optionalArgs object =
    Object.listOf "menuItems" optionalArgs object
        |> Query.rootQuery


menuItem : { id : String } -> List (TypeLocked Argument MenuItem.Type) -> Object menuItem MenuItem.Type -> Field.Query menuItem
menuItem requiredArgs optionalArgs object =
    Object.single "menuItem" (MenuItem.idArg requiredArgs.id :: optionalArgs) object
        |> Query.rootQuery


captains : Field.Query (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Query.rootQuery
