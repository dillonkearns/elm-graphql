module TypeTests exposing (..)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind(..))
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


all : Test
all =
    describe "typekind decoder"
        [ test "decodes" <|
            \_ ->
                """
                {
                  "ofType": {
                    "ofType": null,
                    "name": "String",
                    "kind": "SCALAR"
                  },
                  "name": null,
                  "kind": "NON_NULL"
                }
               """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (Type.RawType
                                { kind = NonNull
                                , name = Nothing
                                , ofType =
                                    Just
                                        (Type.RawType
                                            { kind = TypeKind.Scalar
                                            , name = Just "String"
                                            , ofType = Nothing
                                            }
                                        )
                                }
                            )
                        )
        , test "list of non-null strings" <|
            \_ ->
                """
                              {
                                "ofType": {
                                  "ofType": {
                                    "ofType": null,
                                    "name": "String",
                                    "kind": "SCALAR"
                                  },
                                  "name": null,
                                  "kind": "NON_NULL"
                                },
                                "name": null,
                                "kind": "LIST"
                              }
               """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (Type.RawType
                                { kind = List
                                , name = Nothing
                                , ofType =
                                    Just
                                        (Type.RawType
                                            { kind = NonNull
                                            , name = Nothing
                                            , ofType =
                                                Just
                                                    (Type.RawType
                                                        { kind = TypeKind.Scalar
                                                        , name = Just "String"
                                                        , ofType = Nothing
                                                        }
                                                    )
                                            }
                                        )
                                }
                            )
                        )
        , test "parseRaw string" <|
            \() ->
                Type.RawType
                    { kind = TypeKind.Scalar
                    , name = Just "String"
                    , ofType = Nothing
                    }
                    |> Type.parseRaw
                    |> Expect.equal (Type.Scalar Type.Nullable Scalar.String)
        , test "parse raw boolean" <|
            \() ->
                Type.RawType
                    { kind = TypeKind.Scalar
                    , name = Just "Boolean"
                    , ofType = Nothing
                    }
                    |> Type.parseRaw
                    |> Expect.equal (Type.Scalar Type.Nullable Scalar.Boolean)
        , test "parseRaw non-nullable string" <|
            \() ->
                Type.RawType
                    { kind = NonNull
                    , name = Nothing
                    , ofType =
                        Just
                            (Type.RawType
                                { kind = TypeKind.Scalar
                                , name = Just "String"
                                , ofType = Nothing
                                }
                            )
                    }
                    |> Type.parseRaw
                    |> Expect.equal (Type.Scalar Type.NonNullable Scalar.String)
        , test "parse list of strings" <|
            \() ->
                Type.RawType
                    { kind = TypeKind.List
                    , name = Nothing
                    , ofType =
                        Just
                            (Type.RawType
                                { kind = TypeKind.Scalar
                                , name = Just "String"
                                , ofType = Nothing
                                }
                            )
                    }
                    |> Type.parseRaw
                    |> Expect.equal
                        (Type.List Type.Nullable
                            (Type.Scalar Type.Nullable Scalar.String)
                        )
        , test "parse non-null list of non-null strings" <|
            \() ->
                Type.RawType
                    { kind = TypeKind.NonNull
                    , name = Nothing
                    , ofType =
                        Just
                            (Type.RawType
                                { kind = TypeKind.List
                                , name = Nothing
                                , ofType =
                                    Just
                                        (Type.RawType
                                            { kind = TypeKind.NonNull
                                            , name = Nothing
                                            , ofType =
                                                Just
                                                    (Type.RawType
                                                        { kind = TypeKind.Scalar
                                                        , name = Just "String"
                                                        , ofType = Nothing
                                                        }
                                                    )
                                            }
                                        )
                                }
                            )
                    }
                    |> Type.parseRaw
                    |> Expect.equal
                        (Type.List Type.NonNullable
                            (Type.Scalar Type.NonNullable Scalar.String)
                        )
        ]
