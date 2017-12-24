module QueryCombineTests exposing (..)

import Api.Object.MenuItem as MenuItem
import Api.Query as Query
import Expect
import Graphqelm
import Graphqelm.Builder.Object as SelectionSet exposing (Object)
import Graphqelm.Field as Field exposing (FieldDecoder, Query)
import Graphqelm.Query as Query
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


type alias MenuItem =
    { name : String }


menuItem : SelectionSet MenuItem MenuItem.Type
menuItem =
    MenuItem.selection MenuItem
        |> Object.with MenuItem.name


menusQuery : Query (List MenuItem)
menusQuery =
    menuItem
        |> Query.menuItems identity


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
