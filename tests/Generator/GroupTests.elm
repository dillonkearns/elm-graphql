module Generator.GroupTests exposing (all)

import Expect
import GraphqElm.Generator.Group as Group
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeNew as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "gathers fields from the root query object" <|
            \() ->
                [ rootQuery ]
                    |> Group.gather
                    |> Expect.equal
                        { queries =
                            [ meField
                            , captainsField
                            ]
                        , scalars = []
                        , objects = []
                        , enums = []
                        }
        ]


rootQuery : TypeDefinition
rootQuery =
    Type.TypeDefinition
        "RootQueryType"
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
    }


meField : Type.Field
meField =
    { name = "me"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    }
