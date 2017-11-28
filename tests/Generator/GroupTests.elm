module Generator.GroupTests exposing (all)

import Expect
import GraphqElm.Generator.Group as Group
import GraphqElm.Parser exposing (Field)
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "gathers fields from the root query object" <|
            \() ->
                [ meQuery
                , captainsQuery
                ]
                    |> Group.gather
                    |> Expect.equal
                        { queries =
                            [ meQuery
                            , captainsQuery
                            ]
                        , scalars = []
                        , objects = []
                        , enums = []
                        }
        ]


rootQuery : { name : String, typeOf : TypeDefinition }
rootQuery =
    { name = "RootQueryType"
    , typeOf = Type.Object Type.NonNullable []
    }


meQuery : Field
meQuery =
    { name = "me"
    , typeOf = Type.Scalar Type.NonNullable Scalar.String
    }


captainsQuery : { name : String, typeOf : TypeDefinition }
captainsQuery =
    { name = "captains"
    , typeOf = Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String)
    }
