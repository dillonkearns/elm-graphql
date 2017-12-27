module ResponseTests exposing (all)

import Dict
import Expect
import Graphqelm.Parser.Response
import Json.Decode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "parser"
        [ test "error" <|
            \() ->
                """{"data":null,"errors":[{"message":"You must provide a `first` or `last` value to properly paginate the `releases` connection.","locations":[{"line":4,"column":5}]}]}"""
                    |> Json.Decode.decodeString Graphqelm.Parser.Response.errorDecoder
                    |> Expect.equal
                        (Ok
                            [ { message = "You must provide a `first` or `last` value to properly paginate the `releases` connection."
                              , locations = [ { line = 4, column = 5 } ]
                              , details = Dict.empty
                              }
                            ]
                        )
        ]
