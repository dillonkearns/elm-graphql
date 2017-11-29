module Generator.ObjectTests exposing (..)

import Expect
import GraphqElm.Generator.Object
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "generates list object queries" <|
            \() ->
                GraphqElm.Generator.Object.generateField nameField
                    |> Expect.equal
                        """name : TypeLocked (FieldDecoder String) Type
name =
    Field.fieldDecoder "name" (Decode.string)
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
    }
