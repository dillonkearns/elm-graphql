module Tests exposing (..)

import Expect
import GraphqElm.Field as Field exposing (FieldDecoder, RootQuery)
import GraphqElm.Object as Object exposing (Object)
import Json.Decode as Decode exposing (Decoder)
import Schema.MenuItem as MenuItem
import Schema.Query as Query
import Test exposing (..)


type alias MenuItem =
    { name : String }


type alias MenuItemWithId =
    { name : String, id : String }


menusWithId : RootQuery (List MenuItemWithId)
menusWithId =
    menuItemWithId
        |> Query.menuItems [ MenuItem.contains "Milkshake" ]


menuItem : Object MenuItem
menuItem =
    MenuItem.menuItem MenuItem
        |> Object.with MenuItem.name


menuItemWithId : Object MenuItemWithId
menuItemWithId =
    MenuItem.menuItem MenuItemWithId
        |> Object.with MenuItem.name
        |> Object.with MenuItem.id


menusQuery : RootQuery (List MenuItem)
menusQuery =
    menuItem
        |> Query.menuItems []


all : Test
all =
    describe "GraphqElm"
        [ test "generate menu query" <|
            \_ ->
                Field.fieldDecoderToQuery menusQuery
                    |> Expect.equal
                        """{
menuItems {
name
}
}"""
        , test "generate menu with id query" <|
            \_ ->
                Field.fieldDecoderToQuery menusWithId
                    |> Expect.equal
                        """{
menuItems(contains: "Milkshake") {
id
name
}
}"""
        , test "decodes menu items with id" <|
            \() ->
                """
                {
  "data": {
  "menuItems": [
  {
  "name": "Vanilla Milkshake",
  "id": "2"
  },
  {
  "name": "Chocolate Milkshake",
  "id": "3"
  }
  ] } }"""
                    |> Decode.decodeString (Field.decoder menusWithId)
                    |> Expect.equal
                        (Ok [ { name = "Vanilla Milkshake", id = "2" }, { name = "Chocolate Milkshake", id = "3" } ])
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
