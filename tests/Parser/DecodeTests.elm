module Parser.DecodeTests exposing (all)

import Expect
import GraphqElm.Parser.Scalar as Scalar
import GraphqElm.Parser.Type as Type exposing (..)
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
                    |> Decode.decodeString decoder
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
                    |> Decode.decodeString decoder
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
                    |> Decode.decodeString decoder
                    |> Expect.equal
                        (Ok
                            (TypeDefinition "MenuItem"
                                (ObjectType
                                    [ { name = "description", typeRef = TypeReference (Scalar Scalar.String) NonNullable }
                                    , { name = "id", typeRef = TypeReference (Scalar Scalar.ID) NonNullable }
                                    , { name = "name", typeRef = TypeReference (Scalar Scalar.String) NonNullable }
                                    ]
                                )
                            )
                        )
        ]


decoder : Decoder Type.TypeDefinition
decoder =
    Decode.field "kind" Decode.string
        |> Decode.andThen decodeKind


decodeKind : String -> Decoder Type.TypeDefinition
decodeKind kind =
    case kind of
        "OBJECT" ->
            objectDecoder

        "ENUM" ->
            enumDecoder

        "SCALAR" ->
            scalarDecoder

        _ ->
            Decode.fail ("Unknown kind " ++ kind)


scalarDecoder : Decoder Type.TypeDefinition
scalarDecoder =
    Decode.map (\scalarName -> Type.TypeDefinition scalarName Type.ScalarType)
        (Decode.field "name" Decode.string)


objectDecoder : Decoder Type.TypeDefinition
objectDecoder =
    Decode.map2 createObject
        (Decode.field "name" Decode.string)
        (Type.fieldDecoder
            |> Decode.map (\{ name, ofType } -> { name = name, typeRef = Type.parseRef ofType })
            |> Decode.list
            |> Decode.field "fields"
        )


enumDecoder : Decoder Type.TypeDefinition
enumDecoder =
    Decode.map2 createEnum
        (Decode.field "name" Decode.string)
        (Decode.string
            |> Decode.field "name"
            |> Decode.list
            |> Decode.field "enumValues"
        )


createEnum : String -> List String -> Type.TypeDefinition
createEnum enumName enumValues =
    Type.TypeDefinition enumName (Type.EnumType enumValues)


createObject : String -> List Type.Field -> Type.TypeDefinition
createObject objectName fields =
    Type.TypeDefinition objectName (Type.ObjectType fields)
