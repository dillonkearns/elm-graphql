module Parser.AlternateDecodeTests exposing (all)

import Expect
import GraphqElm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "alternate decoder - top-level"
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
        ]


decoder : Decoder Type.TypeDefinition
decoder =
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
