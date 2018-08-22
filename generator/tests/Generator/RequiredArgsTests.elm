module Generator.RequiredArgsTests exposing (all)

import Expect
import Graphql.Generator.RequiredArgs as RequiredArgs
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type
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
                [ { name = CamelCaseName.build "id"
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
                    |> expectResult
                        { typeAlias = """{ id : String }"""
                        , list = """[ Argument.required "id" requiredArgs.id (Encode.string) ]"""
                        }
        , test "composite" <|
            \() ->
                [ numbersArg ]
                    |> RequiredArgs.generate []
                    |> expectResult
                        { typeAlias = """{ numbers : (List Int) }"""
                        , list = """[ Argument.required "numbers" requiredArgs.numbers (Encode.int |> Encode.list) ]"""
                        }
        , test "multiple primitives" <|
            \() ->
                [ idArg, nameArg ]
                    |> RequiredArgs.generate []
                    |> expectResult
                        { typeAlias = "{ id : String, name : String }"
                        , list = """[ Argument.required "id" requiredArgs.id (Encode.string), Argument.required "name" requiredArgs.name (Encode.string) ]"""
                        }
        , test "normalizes arguments" <|
            \() ->
                [ { name = CamelCaseName.build "type"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                  }
                ]
                    |> RequiredArgs.generate []
                    |> expectResult
                        { typeAlias = "{ type_ : String }"
                        , list = """[ Argument.required "type" requiredArgs.type_ (Encode.string) ]"""
                        }
        ]


expectResult :
    { list : String, typeAlias : String }
    -> Maybe RequiredArgs.Result
    -> Expect.Expectation
expectResult expected actual =
    actual
        |> Maybe.map
            (\value ->
                { list = value.list
                , typeAlias = value.typeAlias.body
                }
            )
        |> Expect.equal (Just expected)


nameArg : Type.Arg
nameArg =
    { name = CamelCaseName.build "name"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }


idArg : Type.Arg
idArg =
    { name = CamelCaseName.build "id"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }


numbersArg : Type.Arg
numbersArg =
    { name = CamelCaseName.build "numbers"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.Scalar Scalar.Int) Type.NonNullable)) Type.NonNullable
    }
