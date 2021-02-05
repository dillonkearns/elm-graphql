module TypeTests exposing (all)

import Expect
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.Type as Type exposing (RawTypeRef(..))
import Graphql.Parser.TypeKind as TypeKind exposing (TypeKind(..))
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
                    |> Decode.decodeString Type.typeRefDecoder
                    |> Expect.equal
                        (Ok
                            (RawTypeRef
                                { name = Nothing
                                , kind = NonNull
                                , ofType = Just (RawTypeRef { name = Just "String", kind = Scalar, ofType = Nothing })
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
                    |> Decode.decodeString Type.typeRefDecoder
                    |> Expect.equal
                        (Ok
                            (RawTypeRef
                                { name = Nothing
                                , kind = List
                                , ofType =
                                    Just
                                        (RawTypeRef
                                            { name = Nothing
                                            , kind = NonNull
                                            , ofType =
                                                Just
                                                    (RawTypeRef
                                                        { name = Just "String"
                                                        , kind = Scalar
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
                RawTypeRef
                    { name = Just "String"
                    , kind = Scalar
                    , ofType = Nothing
                    }
                    |> Type.parseRef
                    |> Expect.equal (Ok (Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable))
        , test "parse raw boolean" <|
            \() ->
                RawTypeRef
                    { name = Just "Boolean"
                    , kind = Scalar
                    , ofType = Nothing
                    }
                    |> Type.parseRef
                    |> Expect.equal (Ok (Type.TypeReference (Type.Scalar Scalar.Boolean) Type.Nullable))
        , test "parseRaw non-nullable string" <|
            \() ->
                RawTypeRef
                    { name = Nothing
                    , kind = NonNull
                    , ofType =
                        Just
                            (RawTypeRef
                                { name = Just "String"
                                , kind = Scalar
                                , ofType = Nothing
                                }
                            )
                    }
                    |> Type.parseRef
                    |> Expect.equal (Ok (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
        , test "parse list of strings" <|
            \() ->
                RawTypeRef
                    { name = Nothing
                    , kind = List
                    , ofType =
                        Just
                            (RawTypeRef
                                { name = Just "String"
                                , kind = Scalar
                                , ofType = Nothing
                                }
                            )
                    }
                    |> Type.parseRef
                    |> Expect.equal
                        (Ok
                            (Type.TypeReference (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable))
                                Type.Nullable
                            )
                        )
        , test "parse non-null list of non-null strings" <|
            \() ->
                RawTypeRef
                    { name = Nothing
                    , kind = NonNull
                    , ofType =
                        Just
                            (RawTypeRef
                                { name = Nothing
                                , kind = List
                                , ofType =
                                    Just
                                        (RawTypeRef
                                            { name = Nothing
                                            , kind = NonNull
                                            , ofType =
                                                Just
                                                    (RawTypeRef
                                                        { name = Just "String"
                                                        , kind = Scalar
                                                        , ofType = Nothing
                                                        }
                                                    )
                                            }
                                        )
                                }
                            )
                    }
                    |> Type.parseRef
                    |> Expect.equal
                        (Ok
                            (Type.TypeReference (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
                                Type.NonNullable
                            )
                        )
        ]
