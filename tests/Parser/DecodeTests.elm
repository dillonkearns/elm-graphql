module Parser.DecodeTests exposing (all)

import Expect
import GraphqElm.Parser.TypeKind as TypeKind
import GraphqElm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "qwer"
        [ test "asdf" <|
            \() ->
                """
                        {
                          "possibleTypes": null,
                          "name": "RootQueryType",
                          "kind": "OBJECT",
                          "fields": [{
                              "type": {
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
                              },
                              "name": "captains",
                              "isDeprecated": false,
                              "description": null,
                              "deprecationReason": null,
                              "args": []
                            }],
                          "inputFields": null,
                          "enumValues": null,
                          "description": null
                        }
              """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (Type.RawTypeDef
                                { name = "RootQueryType"
                                , kind = TypeKind.Object
                                , ofType = Nothing
                                , fields =
                                    Just
                                        [ { name = "captains"
                                          , ofType =
                                                Type.RawTypeRef
                                                    { name = Nothing
                                                    , kind = TypeKind.List
                                                    , ofType =
                                                        Just
                                                            (Type.RawTypeRef
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
                                                            )
                                                    }
                                          }
                                        ]
                                }
                            )
                        )
        ]
