module ResponseTests exposing (all)

import Dict
import Expect
import Graphqelm.Parser.Response
import Json.Decode
import Test exposing (Test, describe, test)


location : Json.Decode.Value
location =
    case
        Json.Decode.decodeString Json.Decode.value """[{"line":4,"column":5}]"""
    of
        Ok value ->
            value

        Err error ->
            Debug.crash ("Couldn't parse json value\n" ++ error)


all : Test
all =
    describe "parser"
        [ test "error" <|
            \() ->
                """{"data":null,"errors":[{"message":"You must provide a `first` or `last` value to properly paginate the `releases` connection.","locations":[{"line":4,"column":5}]}]}"""
                    |> Json.Decode.decodeString Graphqelm.Parser.Response.errorDecoder
                    |> Debug.log "result"
                    |> Expect.equal
                        (Ok
                            [ { message = "You must provide a `first` or `last` value to properly paginate the `releases` connection."
                              , details =
                                    Dict.fromList
                                        [ ( "locations", location ) ]
                              }
                            ]
                        )
        ]
