module EncodeTests exposing (all)

import Expect
import Graphql.Internal.Encode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "encode"
        [ test "string" <|
            \() ->
                Graphql.Internal.Encode.string "hello"
                    |> Graphql.Internal.Encode.serialize
                    |> Expect.equal "\"hello\""
        , test "boolean" <|
            \() ->
                Graphql.Internal.Encode.bool False
                    |> Graphql.Internal.Encode.serialize
                    |> Expect.equal "false"
        , test "int" <|
            \() ->
                Graphql.Internal.Encode.int 123
                    |> Graphql.Internal.Encode.serialize
                    |> Expect.equal "123"
        , test "empty object" <|
            \() ->
                Graphql.Internal.Encode.object
                    []
                    |> Graphql.Internal.Encode.serialize
                    |> Expect.equal """{}"""
        , test "non-empty object" <|
            \() ->
                Graphql.Internal.Encode.object
                    [ ( "number", Graphql.Internal.Encode.int 47 )
                    , ( "boolean", Graphql.Internal.Encode.bool True )
                    , ( "enum", Graphql.Internal.Encode.enum Debug.toString EMPIRE )
                    ]
                    |> Graphql.Internal.Encode.serialize
                    |> Expect.equal """{number: 47, boolean: true, enum: EMPIRE}"""
        ]


type Episode
    = EMPIRE
    | JEDI
    | NEWHOPE
