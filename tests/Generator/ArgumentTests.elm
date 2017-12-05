module Generator.ArgumentTests exposing (all)

import Expect
import Graphqelm.Generator.Argument
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "required argmument generators"
        [ describe "argument list"
            [ test "no arguments gives Nothing" <|
                \() ->
                    []
                        |> Graphqelm.Generator.Argument.requiredArgsString
                        |> Expect.equal Nothing
            , test "all nullable arguments give Nothing" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> Graphqelm.Generator.Argument.requiredArgsString
                        |> Expect.equal Nothing
            , test "single primitive required argument" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                        |> Graphqelm.Generator.Argument.requiredArgsString
                        |> Expect.equal (Just """[ Argument.string "id" requiredArgs.id ]""")
            ]
        , describe "annotations"
            [ test "all nullable arguments give Nothing" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> Graphqelm.Generator.Argument.requiredArgsAnnotation
                        |> Expect.equal Nothing
            , test "single primitive required argument" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                        |> Graphqelm.Generator.Argument.requiredArgsAnnotation
                        |> Expect.equal (Just """{ id : String }""")
            , test "multiple primitive arguments" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    , { name = "name"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                        |> Graphqelm.Generator.Argument.requiredArgsAnnotation
                        |> Expect.equal (Just "{ id : String, name : String }")
            ]
        ]



{-
   droid : { id : String } -> Object droid Api.Object.Droid.Type -> Field.Query droid
   droid requiredArgs object =
       Object.single "droid" [ Argument.string "id" requiredArgs.id ] object
           |> Query.rootQuery
-}
