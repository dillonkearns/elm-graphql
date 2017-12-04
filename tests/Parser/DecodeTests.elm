module Parser.DecodeTests exposing (all)

import Expect
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "decoder - top-level"
        [ test "decodes enums" <|
            \() ->
                """
                 {
                           "possibleTypes": null,
                           "name": "Weather",
                           "kind": "ENUM",
                           "interfaces": null,
                           "inputFields": null,
                           "fields": null,
                           "enumValues": [
                             {
                               "name": "CLOUDY",
                               "isDeprecated": false,
                               "description": null,
                               "deprecationReason": null
                             },
                             {
                               "name": "SUNNY",
                               "isDeprecated": false,
                               "description": null,
                               "deprecationReason": null
                             }
                           ]
                         }
               """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (Type.TypeDefinition "Weather" (Type.EnumType [ "CLOUDY", "SUNNY" ]))
                        )
        , test "scalars" <|
            \() ->
                """
                {
                          "possibleTypes": null,
                          "name": "Date",
                          "kind": "SCALAR",
                          "interfaces": null,
                          "inputFields": null,
                          "fields": null,
                          "enumValues": null
                        }
                              """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (TypeDefinition "Date" ScalarType)
                        )
        , test "decodes object" <|
            \() ->
                """
                        {
          "possibleTypes": null,
          "name": "MenuItem",
          "kind": "OBJECT",
          "interfaces": [],
          "inputFields": null,
          "fields": [
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
              "name": "description",
              "isDeprecated": false,
              "description": null,
              "deprecationReason": null,
              "args": []
            },
            {
              "type": {
                "ofType": {
                  "ofType": null,
                  "name": "ID",
                  "kind": "SCALAR"
                },
                "name": null,
                "kind": "NON_NULL"
              },
              "name": "id",
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
              "name": "name",
              "isDeprecated": false,
              "description": null,
              "deprecationReason": null,
              "args": []
            }
          ],
          "enumValues": null
        }
                        """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (TypeDefinition "MenuItem"
                                (ObjectType
                                    [ { name = "description"
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    , { name = "id"
                                      , typeRef = TypeReference (Scalar Scalar.ID) NonNullable
                                      , args = []
                                      }
                                    , { name = "name"
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    ]
                                )
                            )
                        )
        , test "decodes interface" <|
            \() ->
                """
                {
                         "kind": "INTERFACE",
                         "name": "Character",
                         "fields": [
                           {
                             "name": "id",
                             "description": "The id of the character.",
                             "args": [],
                             "type": {
                               "kind": "NON_NULL",
                               "name": null,
                               "ofType": {
                                 "kind": "SCALAR",
                                 "name": "String",
                                 "ofType": null
                               }
                             },
                             "isDeprecated": false,
                             "deprecationReason": null
                           },
                           {
                             "name": "name",
                             "description": "The name of the character.",
                             "args": [],
                             "type": {
                               "kind": "SCALAR",
                               "name": "String",
                               "ofType": null
                             },
                             "isDeprecated": false,
                             "deprecationReason": null
                           },
                           {
                             "name": "friends",
                             "description": "The friends of the character, or an empty list if they have none.",
                             "args": [],
                             "type": {
                               "kind": "LIST",
                               "name": null,
                               "ofType": {
                                 "kind": "INTERFACE",
                                 "name": "Character",
                                 "ofType": null
                               }
                             },
                             "isDeprecated": false,
                             "deprecationReason": null
                           },
                           {
                             "name": "appearsIn",
                             "description": "Which movies they appear in.",
                             "args": [],
                             "type": {
                               "kind": "LIST",
                               "name": null,
                               "ofType": {
                                 "kind": "ENUM",
                                 "name": "Episode",
                                 "ofType": null
                               }
                             },
                             "isDeprecated": false,
                             "deprecationReason": null
                           }
                         ],
                         "inputFields": null,
                         "interfaces": null,
                         "enumValues": null,
                         "possibleTypes": [
                           {
                             "kind": "OBJECT",
                             "name": "Human",
                             "ofType": null
                           },
                           {
                             "kind": "OBJECT",
                             "name": "Droid",
                             "ofType": null
                           }
                         ]
                       }
                """
                    |> Decode.decodeString Type.decoder
                    |> Expect.equal
                        (Ok
                            (TypeDefinition "Character"
                                (InterfaceType
                                    [ { name = "id"
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    , { name = "name"
                                      , typeRef = TypeReference (Scalar Scalar.String) Nullable
                                      , args = []
                                      }
                                    , { name = "friends"
                                      , typeRef = TypeReference (List (TypeReference (InterfaceRef "Character") Nullable)) Nullable
                                      , args = []
                                      }
                                    , { name = "appearsIn"
                                      , typeRef = TypeReference (List (TypeReference (EnumRef "Episode") Nullable)) Nullable
                                      , args = []
                                      }
                                    ]
                                )
                            )
                        )
        ]
