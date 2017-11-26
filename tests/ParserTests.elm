module ParserTests exposing (all)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (Type)
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
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            [ { name = "captains", typeOf = Type.List Type.Nullable (Type.Scalar Type.NonNullable Scalar.String) }
                            , { name = "me", typeOf = Type.Scalar Type.NonNullable Scalar.String }
                            ]
                        )
        ]


type alias Field =
    { name : String, typeOf : Type.Type }


decoder : Decoder (List Field)
decoder =
    Decode.list
        (Decode.map2 Field
            (Decode.field "name" Decode.string)
            (Decode.field "type"
                (Type.decoder |> Decode.map Type.parseRaw)
            )
        )
        |> Decode.field "fields"
        |> Decode.index 0
        |> Decode.at [ "data", "__schema", "types" ]
