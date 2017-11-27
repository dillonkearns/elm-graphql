module Api.Query exposing (..)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import Json.Decode as Decode exposing (Decoder)


captains : Field.RootQuery (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Field.rootQuery


me : Field.RootQuery String
me =
    Field.custom "me" Decode.string
        |> Field.rootQuery


menuItems : Field.RootQuery (List String)
menuItems =
    Field.custom "menuItems" (Decode.string |> Decode.list)
        |> Field.rootQuery
