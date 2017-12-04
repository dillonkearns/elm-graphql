module Generator.ObjectTests exposing (..)

import Expect
import Graphqelm.Generator.Object
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "generates list object queries" <|
            \() ->
                Graphqelm.Generator.Object.generateField nameField
                    |> Expect.equal
                        """name : FieldDecoder String Type
name =
    Field.fieldDecoder "name" [] (Decode.string)
"""
        ]


objectDefinition : TypeDefinition
objectDefinition =
    Type.TypeDefinition
        "MenuItem"
        (Type.ObjectType
            [ nameField
            ]
        )


nameField : Type.Field
nameField =
    { name = "name"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
