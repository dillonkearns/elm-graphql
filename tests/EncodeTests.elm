module EncodeTests exposing (all)

import Expect
import Graphqelm.Encode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "encode"
        [ test "string" <|
            \() ->
                Graphqelm.Encode.string "hello"
                    |> Graphqelm.Encode.serialize
                    |> Expect.equal "\"hello\""
        , test "boolean" <|
            \() ->
                Graphqelm.Encode.bool False
                    |> Graphqelm.Encode.serialize
                    |> Expect.equal "false"
        ]
