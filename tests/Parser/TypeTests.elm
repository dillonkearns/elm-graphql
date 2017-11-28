module Parser.TypeTests exposing (..)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind(..))
import GraphqElm.Parser.TypeNew as Type
import Test exposing (..)


all : Test
all =
    describe "typekind decoder"
        [ test "parse object definition" <|
            \() ->
                Type.RawTypeDef
                    { name = "MenuItems"
                    , kind = TypeKind.Object
                    , ofType = Nothing
                    , fields =
                        Just
                            [ { name = "description"
                              , ofType =
                                    Type.RawTypeRef
                                        { name = Nothing
                                        , kind = TypeKind.NonNull
                                        , ofType =
                                            Just
                                                (Type.RawTypeRef
                                                    { name = Just "String"
                                                    , kind = TypeKind.Scalar
                                                    , ofType = Nothing
                                                    }
                                                )
                                        }
                              }
                            ]
                    }
                    |> Type.parse
                    |> Expect.equal
                        (Type.TypeDefinition
                            "MenuItems"
                            (Type.ObjectType
                                [ { name = "description"
                                  , typeRef =
                                        Type.TypeReference (Type.Scalar Scalar.String)
                                            Type.NonNullable
                                  }
                                ]
                            )
                            Type.NonNullable
                        )

        -- , test "parse raw boolean" <|
        --     \() ->
        --         Type.RawType
        --             { kind = TypeKind.Scalar
        --             , name = Just "Boolean"
        --             , ofType = Nothing
        --             }
        --             |> Type.parseRaw
        --             |> Expect.equal (Type.Scalar Type.Nullable Scalar.Boolean)
        -- , test "parseRaw non-nullable string" <|
        --     \() ->
        --         Type.RawType
        --             { kind = NonNull
        --             , name = Nothing
        --             , ofType =
        --                 Just
        --                     (Type.RawType
        --                         { kind = TypeKind.Scalar
        --                         , name = Just "String"
        --                         , ofType = Nothing
        --                         }
        --                     )
        --             }
        --             |> Type.parseRaw
        --             |> Expect.equal (Type.Scalar Type.NonNullable Scalar.String)
        -- , test "parse list of strings" <|
        --     \() ->
        --         Type.RawType
        --             { kind = TypeKind.List
        --             , name = Nothing
        --             , ofType =
        --                 Just
        --                     (Type.RawType
        --                         { kind = TypeKind.Scalar
        --                         , name = Just "String"
        --                         , ofType = Nothing
        --                         }
        --                     )
        --             }
        --             |> Type.parseRaw
        --             |> Expect.equal
        --                 (Type.List Type.Nullable
        --                     (Type.Scalar Type.Nullable Scalar.String)
        --                 )
        -- , test "parse non-null list of non-null strings" <|
        --     \() ->
        --         Type.RawType
        --             { kind = TypeKind.NonNull
        --             , name = Nothing
        --             , ofType =
        --                 Just
        --                     (Type.RawType
        --                         { kind = TypeKind.List
        --                         , name = Nothing
        --                         , ofType =
        --                             Just
        --                                 (Type.RawType
        --                                     { kind = TypeKind.NonNull
        --                                     , name = Nothing
        --                                     , ofType =
        --                                         Just
        --                                             (Type.RawType
        --                                                 { kind = TypeKind.Scalar
        --                                                 , name = Just "String"
        --                                                 , ofType = Nothing
        --                                                 }
        --                                             )
        --                                     }
        --                                 )
        --                         }
        --                     )
        --             }
        --             |> Type.parseRaw
        --             |> Expect.equal
        --                 (Type.List Type.NonNullable
        --                     (Type.Scalar Type.NonNullable Scalar.String)
        --                 )
        ]
