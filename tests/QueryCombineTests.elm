module QueryCombineTests exposing (..)

import Expect
import GraphqElm.Field as Field exposing (FieldDecoder, Query)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)
import Schema.MenuItem as MenuItem
import Schema.Query as Query
import Test exposing (..)


type alias MenuItem =
    { name : String }


menuItem : Object MenuItem MenuItem.Type
menuItem =
    MenuItem.build MenuItem
        |> Object.with MenuItem.name


menusQuery : Query (List MenuItem)
menusQuery =
    menuItem
        |> Query.menuItems []


combinedQueries : Query ( List String, List MenuItem )
combinedQueries =
    Query.combine (,) Query.captains menusQuery


all : Test
all =
    describe "GraphqElm"
        [ test "generate combined query" <|
            \_ ->
                Field.toQuery combinedQueries
                    |> Expect.equal
                        """{
captains
menuItems {
name
}
}"""
        , test "decode captains" <|
            \() ->
                """
                                      {
                        "data": {
                        "menuItems": [
                        {"name": "Masala Chai"}
                        ],
                        "captains":
                        [ "Kirk", "Picard" ]
                         }
                        }
                         """
                    |> Decode.decodeString (Field.decoder combinedQueries)
                    |> Expect.equal
                        (Ok
                            ( [ "Kirk", "Picard" ]
                            , [ { name = "Masala Chai" } ]
                            )
                        )
        ]
