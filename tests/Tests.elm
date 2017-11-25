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


menuItem : Object MenuItem MenuItem.Type
menuItem =
    MenuItem.menuItem MenuItem
        |> Object.with MenuItem.name


menuItemWithId : Object MenuItemWithId MenuItem.Type
menuItemWithId =
    MenuItem.menuItem MenuItemWithId
        |> Object.with MenuItem.name
        |> Object.with MenuItem.id


menusQuery : RootQuery (List MenuItem)
menusQuery =
    menuItem
        |> Query.menuItems []


menuQuery : RootQuery MenuItem
menuQuery =
    menuItem
        |> Query.menuItem { id = "123" } []


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
                    |> Decode.decodeString (Field.decoder menusQuery)
                    |> Expect.equal
                        (Ok [ { name = "Masala Chai" }, { name = "Vanilla Milkshake" }, { name = "Chocolate Milkshake" } ])
        , test "generate menuItem query" <|
            \_ ->
                Field.fieldDecoderToQuery menuQuery
                    |> Expect.equal
                        """{
menuItem(id: "123") {
name
}
}"""
        , test "decode menu item" <|
            \() ->
                """
              {
"data": {
"menuItem":
{
"name": "Masala Chai"
}
 } }"""
                    |> Decode.decodeString (Field.decoder menuQuery)
                    |> Expect.equal
                        (Ok { name = "Masala Chai" })
        , test "generate captains query" <|
            \_ ->
                Field.fieldDecoderToQuery Query.captains
                    |> Expect.equal
                        """{
captains
}"""
        , test "decode captains" <|
            \() ->
                """
                                      {
                        "data": {
                        "captains":
                        [ "Kirk", "Picard" ]
                         }
                        }
                         """
                    |> Decode.decodeString (Field.decoder Query.captains)
                    |> Expect.equal
                        (Ok [ "Kirk", "Picard" ])
        ]



-- menusDecoder : Decoder (List MenuItem)
-- menusDecoder =
--     Decode.at [ "data", "menuItems" ]
--         (Decode.list
--             (Decode.map MenuItem
--                 (Decode.field "name" Decode.string)
--             )
--         )
