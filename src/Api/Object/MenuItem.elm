module Api.Object.MenuItem exposing (..)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)


type Type
    = Type


description : Field.Query String
description =
    Field.custom "description" Decode.string
        |> Query.rootQuery


id : Field.Query String
id =
    Field.custom "id" Decode.string
        |> Query.rootQuery


name : Field.Query String
name =
    Field.custom "name" Decode.string
        |> Query.rootQuery
