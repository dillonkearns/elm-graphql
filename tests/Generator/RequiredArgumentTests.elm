module Generator.RequiredArgumentTests exposing (all)

import Expect
import Graphqelm.Generator.RequiredArgument as RequiredArgument
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "required argmument generators"
        [ describe "argument list"
            [ test "no arguments" <|
                \() ->
                    []
                        |> RequiredArgument.requiredArgsString
                        |> Expect.equal Nothing
            , test "all nullable arguments" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> RequiredArgument.requiredArgsString
                        |> Expect.equal Nothing
            , test "single primitive" <|
                \() ->
                    [ idArg ]
                        |> RequiredArgument.requiredArgsString
                        |> Expect.equal (Just """[ Argument.string "id" requiredArgs.id ]""")
            , test "multiple primitives" <|
                \() ->
                    [ idArg, nameArg ]
                        |> RequiredArgument.requiredArgsString
                        |> Expect.equal (Just """[ Argument.string "id" requiredArgs.id, Argument.string "name" requiredArgs.name ]""")
            ]
        , describe "annotations"
            [ test "all nullable arguments" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> RequiredArgument.requiredArgsAnnotation
                        |> Expect.equal Nothing
            , test "single primitive" <|
                \() ->
                    [ idArg ]
                        |> RequiredArgument.requiredArgsAnnotation
                        |> Expect.equal (Just """{ id : String }""")
            , test "multiple primitives" <|
                \() ->
                    [ idArg
                    , nameArg
                    ]
                        |> RequiredArgument.requiredArgsAnnotation
                        |> Expect.equal (Just "{ id : String, name : String }")
            , test "normalizes arguments" <|
                \() ->
                    [ { name = "type", typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable } ]
                        |> RequiredArgument.generate
                        |> Expect.equal
                            (Just
                                { annotation = "{ type_ : String }"
                                , list = """[ Argument.string "type" requiredArgs.type_ ]"""
                                }
                            )
            ]
        ]


nameArg : Type.Arg
nameArg =
    { name = "name"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }


idArg : Type.Arg
idArg =
    { name = "id"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }
