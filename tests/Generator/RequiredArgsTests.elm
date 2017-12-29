module Generator.RequiredArgsTests exposing (all)

import Expect
import Graphqelm.Generator.RequiredArgs as RequiredArgs
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "required argmument generators"
        [ test "no arguments" <|
            \() ->
                []
                    |> RequiredArgs.generate []
                    |> Expect.equal Nothing
        , test "all nullable arguments" <|
            \() ->
                [ { name = "id"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> RequiredArgs.generate []
                    |> Expect.equal Nothing
        , test "single primitive" <|
            \() ->
                [ idArg ]
                    |> RequiredArgs.generate []
                    |> Expect.equal
                        (Just
                            { annotation = """{ id : String }"""
                            , list = """[ Argument.required "id" requiredArgs.id (Encode.string) ]"""
                            }
                        )
        , test "composite" <|
            \() ->
                [ numbersArg ]
                    |> RequiredArgs.generate []
                    |> Expect.equal
                        (Just
                            { annotation = """{ numbers : (List Int) }"""
                            , list = """[ Argument.required "numbers" requiredArgs.numbers (Encode.int |> Encode.list) ]"""
                            }
                        )
        , test "multiple primitives" <|
            \() ->
                [ idArg, nameArg ]
                    |> RequiredArgs.generate []
                    |> Expect.equal
                        (Just
                            { annotation = "{ id : String, name : String }"
                            , list = """[ Argument.required "id" requiredArgs.id (Encode.string), Argument.required "name" requiredArgs.name (Encode.string) ]"""
                            }
                        )
        , test "normalizes arguments" <|
            \() ->
                [ { name = "type"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                  }
                ]
                    |> RequiredArgs.generate []
                    |> Expect.equal
                        (Just
                            { annotation = "{ type_ : String }"
                            , list = """[ Argument.required "type" requiredArgs.type_ (Encode.string) ]"""
                            }
                        )
        ]


nameArg : Type.Arg
nameArg =
    { name = "name"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }


idArg : Type.Arg
idArg =
    { name = "id"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }


numbersArg : Type.Arg
numbersArg =
    { name = "numbers"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.Scalar Scalar.Int) Type.NonNullable)) Type.NonNullable
    }
