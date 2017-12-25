module EncodeTests exposing (all)

import Expect
import Graphqelm.Encode
import Test exposing (Test, describe, test)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


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
        , test "int" <|
            \() ->
                Graphqelm.Encode.int 123
                    |> Graphqelm.Encode.serialize
                    |> Expect.equal "123"
        , test "empty object" <|
            \() ->
                Graphqelm.Encode.object
                    []
                    |> Graphqelm.Encode.serialize
                    |> Expect.equal """{}"""
        , test "non-empty object" <|
            \() ->
                Graphqelm.Encode.object
                    [ "number" => Graphqelm.Encode.int 47
                    , "boolean" => Graphqelm.Encode.bool True
                    , "enum" => Graphqelm.Encode.enum toString EMPIRE
                    ]
                    |> Graphqelm.Encode.serialize
                    |> Expect.equal """{number: 47, boolean: true, enum: EMPIRE}"""
        ]


type Episode
    = EMPIRE
    | JEDI
    | NEWHOPE
