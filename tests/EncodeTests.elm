module EncodeTests exposing (all)

import Expect
import Graphqelm.Internal.Encode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "encode"
        [ test "string" <|
            \() ->
                Graphqelm.Internal.Encode.string "hello"
                    |> Graphqelm.Internal.Encode.serialize
                    |> Expect.equal "\"hello\""
        , test "boolean" <|
            \() ->
                Graphqelm.Internal.Encode.bool False
                    |> Graphqelm.Internal.Encode.serialize
                    |> Expect.equal "false"
        , test "int" <|
            \() ->
                Graphqelm.Internal.Encode.int 123
                    |> Graphqelm.Internal.Encode.serialize
                    |> Expect.equal "123"
        , test "empty object" <|
            \() ->
                Graphqelm.Internal.Encode.object
                    []
                    |> Graphqelm.Internal.Encode.serialize
                    |> Expect.equal """{}"""
        , test "non-empty object" <|
            \() ->
                Graphqelm.Internal.Encode.object
                    [ ( "number", Graphqelm.Internal.Encode.int 47 )
                    , ( "boolean", Graphqelm.Internal.Encode.bool True )
                    , ( "enum", Graphqelm.Internal.Encode.enum toString EMPIRE )
                    ]
                    |> Graphqelm.Internal.Encode.serialize
                    |> Expect.equal """{number: 47, boolean: true, enum: EMPIRE}"""
        ]


type Episode
    = EMPIRE
    | JEDI
    | NEWHOPE
