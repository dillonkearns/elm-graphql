module QueryCombineTests exposing (..)

import Api.Object.MenuItem as MenuItem
import Api.Query as Query
import Expect
import Graphqelm.Field as Field exposing (FieldDecoder, Query)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Graphqelm
import Json.Decode as Decode exposing (Decoder)
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
        |> Query.menuItems Graphqelm.noOptionalArgs


combinedQueries : Query ( Maybe (List String), List MenuItem )
combinedQueries =
    Query.combine (,) Query.captains menusQuery


all : Test
all =
    describe "Graphqelm"
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
                            ( Just [ "Kirk", "Picard" ]
                            , [ { name = "Masala Chai" } ]
                            )
                        )
        ]
