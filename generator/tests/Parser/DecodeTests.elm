module Parser.DecodeTests exposing (all)

import Expect
import Graphql.Generator.Group as Group
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type exposing (..)
import Json.Decode as Decode
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
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (typeDefinition "Weather"
                                (EnumType
                                    [ { name = ClassCaseName.build "CLOUDY", description = Nothing }
                                    , { name = ClassCaseName.build "SUNNY", description = Nothing }
                                    ]
                                )
                                Nothing
                            )
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
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (typeDefinition "Date" ScalarType Nothing)
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
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (typeDefinition "MenuItem"
                                (ObjectType
                                    [ { name = CamelCaseName.build "description"
                                      , description = Nothing
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    , { name = CamelCaseName.build "id"
                                      , description = Nothing
                                      , typeRef = TypeReference (Scalar (Scalar.Custom (ClassCaseName.build "ID"))) NonNullable
                                      , args = []
                                      }
                                    , { name = CamelCaseName.build "name"
                                      , description = Nothing
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    ]
                                    []
                                )
                                Nothing
                            )
                        )
        , test "decodes non-nullable object" <|
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
                              "name": "stargazers",
                              "description": "A list of users who have starred this starrable.",
                              "args": [],
                              "type": {
                                "kind": "NON_NULL",
                                "name": null,
                                "ofType": {
                                  "kind": "OBJECT",
                                  "name": "StargazerConnection",
                                  "ofType": null
                                }
                              },
                              "isDeprecated": false,
                              "deprecationReason": null
                            }
                            ]}
                                        """
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (typeDefinition "MenuItem"
                                (ObjectType
                                    [ { name = CamelCaseName.build "stargazers"
                                      , description = Just "A list of users who have starred this starrable."
                                      , typeRef = TypeReference (ObjectRef "StargazerConnection") NonNullable
                                      , args = []
                                      }
                                    ]
                                    []
                                )
                                Nothing
                            )
                        )
        , test "field with interface ref" <|
            \() ->
                """
                      {
                        "types": [
                          {
                            "kind": "INTERFACE",
                            "name": "Character",
                            "description": null,
                            "specifiedByUrl": null,
                            "fields": [
                              {
                                "type": {
                                  "ofType": {
                                    "ofType": {
                                      "ofType": {
                                        "name": "Character",
                                        "kind": "INTERFACE"
                                      },
                                      "name": null,
                                      "kind": "NON_NULL"
                                    },
                                    "name": null,
                                    "kind": "LIST"
                                  },
                                  "name": null,
                                  "kind": "NON_NULL"
                                },
                                "name": "friends",
                                "isDeprecated": false,
                                "description": null,
                                "deprecationReason": null,
                                "args": []
                              }
                            ],
                            "inputFields": null,
                            "interfaces": [],
                            "enumValues": null,
                            "possibleTypes": [
                              {
                                "kind": "OBJECT",
                                "name": "Human",
                                "ofType": null
                              }
                            ]
                          },
                          {
                            "kind": "OBJECT",
                            "name": "Human",
                            "description": null,
                            "specifiedByUrl": null,
                            "fields": [
                              {
                                "type": {
                                  "ofType": {
                                    "ofType": {
                                      "ofType": {
                                        "name": "Character",
                                        "kind": "INTERFACE"
                                      },
                                      "name": null,
                                      "kind": "NON_NULL"
                                    },
                                    "name": null,
                                    "kind": "LIST"
                                  },
                                  "name": null,
                                  "kind": "NON_NULL"
                                },
                                "name": "friends",
                                "isDeprecated": false,
                                "description": null,
                                "deprecationReason": null,
                                "args": []
                              }
                            ],
                            "inputFields": null,
                            "interfaces": [
                              {
                                "kind": "INTERFACE",
                                "name": "Character",
                                "ofType": null
                              }
                            ],
                            "enumValues": null,
                            "possibleTypes": null
                          }
                        ]
                      }
                                                        """
                    |> Decode.decodeString (Decode.field "types" (Decode.list decoder))
                    |> Expect.equal
                        (Ok
                            [ typeDefinition "Character"
                                (InterfaceType
                                    [ { name = CamelCaseName.build "friends"
                                      , description = Nothing
                                      , typeRef =
                                            TypeReference
                                                (List (TypeReference (InterfaceRef "Character") NonNullable))
                                                NonNullable
                                      , args = []
                                      }
                                    ]
                                    [ ClassCaseName.build "Human" ]
                                    []
                                )
                                Nothing
                            , typeDefinition "Human"
                                (ObjectType
                                    [ { name = CamelCaseName.build "friends"
                                      , description = Nothing
                                      , typeRef =
                                            TypeReference
                                                (List (TypeReference (InterfaceRef "Character") NonNullable))
                                                NonNullable
                                      , args = []
                                      }
                                    ]
                                    [ ClassCaseName.build "Character" ]
                                )
                                Nothing
                            ]
                        )
        , test "decodes input object arg" <|
            \() ->
                """
                                        {
                          "possibleTypes": null,
                          "name": "Query",
                          "kind": "OBJECT",
                          "interfaces": [],
                          "inputFields": null,
                          "fields": [
                            {
                              "type": {
                                "ofType": {
                                  "ofType": null,
                                  "name": "MenuItem",
                                  "kind": "OBJECT"
                                },
                                "name": null,
                                "kind": "LIST"
                              },
                              "name": "menuItems",
                              "isDeprecated": false,
                              "description": null,
                              "deprecationReason": null,
                              "args": [
                                {
                                  "type": {
                                    "ofType": {
                                      "ofType": null,
                                      "name": "FilterOptions",
                                      "kind": "INPUT_OBJECT"
                                    },
                                    "name": null,
                                    "kind": "NON_NULL"
                                  },
                                  "name": "filterOptions",
                                  "isDeprecated": false,
                                  "description": null,
                                  "deprecationReason": null,
                                  "defaultValue": null
                                }
                              ]
                            }
                          ],
                          "enumValues": null
                        }
                                        """
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (typeDefinition "Query"
                                (ObjectType
                                    [ { name = CamelCaseName.build "menuItems"
                                      , description = Nothing
                                      , typeRef = TypeReference (List (TypeReference (ObjectRef "MenuItem") Nullable)) Nullable
                                      , args =
                                            [ { name = CamelCaseName.build "filterOptions"
                                              , description = Nothing
                                              , typeRef = TypeReference ("FilterOptions" |> ClassCaseName.build |> InputObjectRef) NonNullable
                                              }
                                            ]
                                      }
                                    ]
                                    []
                                )
                                Nothing
                            )
                        )
        , test "decodes interface" <|
            \() ->
                """
                {
                        "types": [
                          {
                            "kind": "INTERFACE",
                            "name": "Character",
                            "description": null,
                            "specifiedByUrl": null,
                            "fields": [{
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
                            }],
                            "inputFields": null,
                            "interfaces": [],
                            "enumValues": null,
                            "possibleTypes": [
                              {
                                "kind": "OBJECT",
                                "name": "Human",
                                "ofType": null
                              }
                            ]
                          },
                          {
                            "kind": "INTERFACE",
                            "name": "Biological",
                            "description": null,
                            "specifiedByUrl": null,
                            "fields": [{
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
                            }],
                            "inputFields": null,
                            "interfaces": [
                              {
                                "kind": "INTERFACE",
                                "name": "Character",
                                "ofType": null
                              }
                            ],
                            "enumValues": null,
                            "possibleTypes": [
                              {
                                "kind": "OBJECT",
                                "name": "Human",
                                "ofType": null
                              }
                            ]
                          },
                          {
                            "kind": "OBJECT",
                            "name": "Human",
                            "description": null,
                            "specifiedByUrl": null,
                            "fields": [{
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
                            }],
                            "inputFields": null,
                            "interfaces": [
                              {
                                "kind": "INTERFACE",
                                "name": "Biological",
                                "ofType": null
                              },
                              {
                                "kind": "INTERFACE",
                                "name": "Character",
                                "ofType": null
                              }
                            ],
                            "enumValues": null,
                            "possibleTypes": null
                          }
                        ]
                      }
                """
                    |> Decode.decodeString (Decode.field "types" (Decode.list decoder))
                    |> Result.map Group.interfaceImplementorsDict
                    |> Expect.equal
                        (Ok
                            [ typeDefinition "Character"
                                (InterfaceType
                                    [ { name = CamelCaseName.build "id"
                                      , description = Just "The id of the character."
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    ]
                                    [ ClassCaseName.build "Human" ]
                                    []
                                )
                                Nothing
                            , typeDefinition "Biological"
                                (InterfaceType
                                    [ { name = CamelCaseName.build "id"
                                      , description = Just "The id of the character."
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    ]
                                    [ ClassCaseName.build "Human" ]
                                    [ ClassCaseName.build "Character" ]
                                )
                                Nothing
                            , typeDefinition "Human"
                                (ObjectType
                                    [ { name = CamelCaseName.build "id"
                                      , description = Just "The id of the character."
                                      , typeRef = TypeReference (Scalar Scalar.String) NonNullable
                                      , args = []
                                      }
                                    ]
                                    [ ClassCaseName.build "Biological", ClassCaseName.build "Character" ]
                                )
                                Nothing
                            ]
                            |> Result.map Group.interfaceImplementorsDict
                        )
        ]
