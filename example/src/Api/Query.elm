module Api.Query exposing (..)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import Json.Decode as Decode exposing (Decoder)


captains : Field.Query (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Field.rootQuery


me : Field.Query String
me =
    Field.custom "me" Decode.string
        |> Field.rootQuery


menuItems : Field.Query (List String)
menuItems =
    Field.custom "menuItems" (Decode.string |> Decode.list)
        |> Field.rootQuery
