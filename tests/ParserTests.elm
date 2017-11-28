module ParserTests exposing (all)

import Expect
import GraphqElm.Parser
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import GraphqElm.Parser.TypeNew as TypeNew
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


all : Test
all =
    describe "parser"
        [ test "parse non-object types" <|
            \() ->
                """
                {
                  "data": {
                    "__schema": {
                      "types": [
                        {
                          "possibleTypes": null,
                          "name": "QueryType",
                          "kind": "OBJECT",
                          "interfaces": [],
                          "inputFields": null,
                          "fields": [
                            {
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
                            },
                            {
                              "type": {
                                "ofType": {
                                  "ofType": null,
                                  "name": "String",
                                  "kind": "SCALAR"
                                },
                                "name": null,
                                "kind": "NON_NULL"
                              },
                              "name": "me",
                              "isDeprecated": false,
                              "description": null,
                              "deprecationReason": null,
                              "args": []
                            }
                          ],
                          "enumValues": null,
                          "description": null
                        }
                      ]
                    }
                  }
                }
"""
                    |> Decode.decodeString GraphqElm.Parser.decoder
                    |> Expect.equal
                        (Ok
                            [ { name = "captains", typeOf = Type.List Type.Nullable (Type.Scalar Type.NonNullable Scalar.String) }
                            , { name = "me", typeOf = Type.Scalar Type.NonNullable Scalar.String }
                            ]
                        )
        , test "new parser" <|
            \() ->
                """
                                        {
                                          "data": {
                                            "__schema": {
                                              "types": [
                                                {
                                                  "possibleTypes": null,
                                                  "name": "RootQueryType",
                                                  "kind": "OBJECT",
                                                  "interfaces": [],
                                                  "inputFields": null,
                                                  "fields": [
                                                    {
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
                                                    },
                                                    {
                                                      "type": {
                                                        "ofType": {
                                                          "ofType": null,
                                                          "name": "String",
                                                          "kind": "SCALAR"
                                                        },
                                                        "name": null,
                                                        "kind": "NON_NULL"
                                                      },
                                                      "name": "me",
                                                      "isDeprecated": false,
                                                      "description": null,
                                                      "deprecationReason": null,
                                                      "args": []
                                                    }
                                                  ],
                                                  "enumValues": null,
                                                  "description": null
                                                }
                                              ]
                                            }
                                          }
                                        }
                        """
                    |> Decode.decodeString GraphqElm.Parser.decoderNew
                    |> Expect.equal
                        (Ok
                            { queries =
                                [ { name = "captains"
                                  , typeRef =
                                        TypeNew.TypeReference
                                            (TypeNew.List
                                                (TypeNew.TypeReference (TypeNew.Scalar Scalar.String) TypeNew.NonNullable)
                                            )
                                            TypeNew.Nullable
                                  }
                                , { name = "me", typeRef = TypeNew.TypeReference (TypeNew.Scalar Scalar.String) TypeNew.NonNullable }
                                ]
                            , scalars = []
                            , objects = []
                            , enums = []
                            }
                        )
        ]
