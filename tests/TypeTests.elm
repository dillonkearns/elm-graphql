module TypeTests exposing (..)

import Expect
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
                    |> Expect.equal (Type.Type Type.Nullable Type.String)
        , test "parse raw boolean" <|
            \() ->
                Type.RawType
                    { kind = TypeKind.Scalar
                    , name = Just "Boolean"
                    , ofType = Nothing
                    }
                    |> Type.parseRaw
                    |> Expect.equal (Type.Type Type.Nullable Type.Boolean)
        ]



-- Type ListType NonNullable (Type NonNullable StringType)
