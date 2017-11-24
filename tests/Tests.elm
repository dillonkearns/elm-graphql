module Tests exposing (..)

import Expect
import GraphqElm.Field as Field exposing (FieldDecoder)
import Json.Decode as Decode exposing (Decoder)
import Schema.Human as Human
import Schema.MenuItem as MenuItem
import Schema.Query as Query
import Test exposing (..)


type alias Human =
    { name : String }


query : Field.FieldDecoder { name : String }
query =
    Human.human Human { id = "1000" } []
        |> Field.with Human.name


type alias MenuItem =
    { name : String }


menusQuery : FieldDecoder (List MenuItem)
menusQuery =
    Query.menuItem MenuItem
        |> Field.with MenuItem.name
        |> Query.menuItems


all : Test
all =
    describe "GraphqElm"
        [ test "generate query document" <|
            \_ ->
                Field.fieldDecoderToQuery query
                    |> Expect.equal
                        """{
human(id: "1000") {
name
}
}"""

        --         , test "decodes human properly" <|
        --             \() ->
        --                 """{
        --   "data": {
        --     "human": {
        --       "name": "Luke Skywalker"
        --     }
        --   }
        -- }"""
        --                     |> Decode.decodeString (Field.decoder query)
        --                     |> Expect.equal
        --                         (Ok { name = "Luke Skywalker" })
        , test "generate menu query" <|
            \_ ->
                Field.fieldDecoderToQuery menusQuery
                    |> Expect.equal
                        """{
menuItems {
name
}
}"""
        , test "decodes menu items" <|
            \() ->
                """
                {
  "data": {
  "menuItems": [
  {
  "name": "Masala Chai"
  },
  {
  "name": "Vanilla Milkshake"
  },
  {
  "name": "Chocolate Milkshake"
  }
  ] } }"""
                    |> Decode.decodeString menusDecoder
                    |> Expect.equal
                        (Ok [ { name = "Masala Chai" }, { name = "Vanilla Milkshake" }, { name = "Chocolate Milkshake" } ])
        ]


menusDecoder : Decoder (List MenuItem)
menusDecoder =
    Field.decoder menusQuery



-- menusDecoder : Decoder (List MenuItem)
-- menusDecoder =
--     Decode.at [ "data", "menuItems" ]
--         (Decode.list
--             (Decode.map MenuItem
--                 (Decode.field "name" Decode.string)
--             )
--         )
