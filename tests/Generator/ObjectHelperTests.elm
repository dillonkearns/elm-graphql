module Generator.ObjectHelperTests exposing (..)

import Expect
import GraphqElm.Generator.Query
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "object helpers"
        [ test "generates correct functions for scalar queries" <|
            \() ->
                meField
                    |> GraphqElm.Generator.Query.generateNew
                    |> Expect.equal """me : Field.Query (String)
me =
    Field.custom "me" (Decode.string)
        |> Query.rootQuery
"""

        --         , test "generates object queries" <|
        --             \() ->
        --                 menuItemField
        --                     |> GraphqElm.Generator.Query.generateNew
        --                     |> Expect.equal """menuItem : Object menuItem Api.Object.MenuItem.Type -> Field.Query menuItem
        -- menuItem object =
        --     Object.single "menuItem" optionalArgs object
        --         |> Query.rootQuery
        -- """
        --         , test "generates list object queries" <|
        --             \() ->
        --                 menuItemsField
        --                     |> GraphqElm.Generator.Query.generateNew
        --                     |> Expect.equal """menuItems : Object menuItem Api.Object.MenuItem.Type -> Field.Query (List menuItem)
        -- menuItems object =
        --     Object.listOf "menuItems" optionalArgs object
        --         |> Query.rootQuery
        -- """
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
