module Api.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)


captains : Field.RootQuery (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Field.rootQuery


me : Field.RootQuery (String)
me =
    Field.custom "me" (Decode.string)
        |> Field.rootQuery


menuItems : Field.RootQuery (List String)
menuItems =
    Field.custom "menuItems" (Decode.string |> Decode.list)
        |> Field.rootQuery
