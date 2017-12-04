module Tests exposing (..)

import Api.Object.MenuItem as MenuItem
import Api.Query as Query
import Expect
import Graphqelm.Field as Field exposing (FieldDecoder, Query)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


type alias MenuItem =
    { name : String }


type alias MenuItemWithId =
    { name : String, id : String }


menusWithId : Query (List MenuItemWithId)
menusWithId =
    menuItemWithId
        |> Query.menuItems (\args -> { args | contains = Just "Milkshake" })


menuItem : Object MenuItem MenuItem.Type
menuItem =
    MenuItem.build MenuItem
        |> Object.with MenuItem.name


menuItemWithId : Object MenuItemWithId MenuItem.Type
menuItemWithId =
    MenuItem.build MenuItemWithId
        |> Object.with MenuItem.name
        |> Object.with MenuItem.id


menusQuery : Query (List MenuItem)
menusQuery =
    menuItem
        |> Query.menuItems identity



-- menuQuery : Query MenuItem
-- menuQuery =
--     menuItem
--         |> Query.menuItem { id = "123" } []


all : Test
all =
    describe "Graphqelm"
        [ test "generate menu query" <|
            \_ ->
                Field.toQuery menusQuery
                    |> Expect.equal
                        """{
menuItems {
name
}
}"""
        , test "generate menu with id query" <|
            \_ ->
                Field.toQuery menusWithId
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

        --         , test "generate menuItem query" <|
        --             \_ ->
        --                 Field.toQuery menuQuery
        --                     |> Expect.equal
        --                         """{
        -- menuItem(id: "123") {
        -- name
        -- }
        -- }"""
        --         , test "decode menu item" <|
        --             \() ->
        --                 """
        --               {
        -- "data": {
        -- "menuItem":
        -- {
        -- "name": "Masala Chai"
        -- }
        --  } }"""
        --                     |> Decode.decodeString (Field.decoder menuQuery)
        --                     |> Expect.equal
        --                         (Ok { name = "Masala Chai" })
        , test "generate captains query" <|
            \_ ->
                Field.toQuery Query.captains
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
                        (Ok (Just [ "Kirk", "Picard" ]))
        ]
