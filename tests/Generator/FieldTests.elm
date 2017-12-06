module Generator.FieldTests exposing (..)

import Expect
import Graphqelm.Generator.Field as Field
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "field generator"
        [ test "simple scalar" <|
            \() ->
                meField
                    |> Field.toThing "Foo"
                    |> Field.toQuery
                    |> Expect.equal
                        """me : Field.Query (String)
me =
      Field.fieldDecoder "me" [] (Decode.string)
          |> Query.rootQuery
"""
        ]


rootQuery : TypeDefinition
rootQuery =
    Type.TypeDefinition
        "Query"
        (Type.ObjectType
            [ meField
            , captainsField
            ]
        )


captainsField : Type.Field
captainsField =
    { name = "captains"
    , typeRef =
        Type.TypeReference
            (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
            Type.NonNullable
    , args = []
    }


menuItemsField : Type.Field
menuItemsField =
    { name = "menuItems"
    , typeRef =
        Type.TypeReference
            (Type.List
                (Type.TypeReference
                    (Type.ObjectRef "MenuItem")
                    Type.NonNullable
                )
            )
            Type.NonNullable
    , args = []
    }


menuItemField : Type.Field
menuItemField =
    { name = "menuItem"
    , typeRef = Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable
    , args = []
    }


meField : Type.Field
meField =
    { name = "me"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
