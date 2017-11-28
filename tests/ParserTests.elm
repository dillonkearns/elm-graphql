module ParserTests exposing (all)

import Expect
import GraphqElm.Parser
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type
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
                                        Type.TypeReference
                                            (Type.List
                                                (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable)
                                            )
                                            Type.Nullable
                                  }
                                , { name = "me", typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable }
                                ]
                            , scalars = []
                            , objects = []
                            , enums = []
                            }
                        )
        ]
