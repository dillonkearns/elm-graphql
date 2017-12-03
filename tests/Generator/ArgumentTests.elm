module Generator.ArgumentTests exposing (all)

import Expect
import GraphqElm.Generator.Argument
import GraphqElm.Parser.Scalar as Scalar
import GraphqElm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "required argmument generators"
        [ describe "argument list"
            [ test "no arguments gives Nothing" <|
                \() ->
                    []
                        |> GraphqElm.Generator.Argument.requiredArgsString
                        |> Expect.equal Nothing
            , test "all nullable arguments give Nothing" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> GraphqElm.Generator.Argument.requiredArgsString
                        |> Expect.equal Nothing
            , test "single primitive required argument" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                        |> GraphqElm.Generator.Argument.requiredArgsString
                        |> Expect.equal (Just """[ Argument.string "id" requiredArgs.id ]""")
            ]
        , describe "annotations"
            [ test "all nullable arguments give Nothing" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                        |> GraphqElm.Generator.Argument.requiredArgsAnnotation
                        |> Expect.equal Nothing
            , test "single primitive required argument" <|
                \() ->
                    [ { name = "id"
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                        |> GraphqElm.Generator.Argument.requiredArgsAnnotation
                        |> Expect.equal (Just """{ id : String }""")
            ]
        ]



{-
   droid : { id : String } -> Object droid Api.Object.Droid.Type -> Field.Query droid
   droid requiredArgs object =
       Object.single "droid" [ Argument.string "id" requiredArgs.id ] object
           |> Query.rootQuery
-}
