module Generator.TypeLockDefinitionsTests exposing (all)

import Expect
import Graphqelm.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphqelm.Parser.Type as Type exposing (..)
import Test exposing (..)


definitions : List a
definitions =
    []


all : Test
all =
    describe "object types generator"
        [ test "enum has no object definitions" <|
            \() ->
                [ Type.TypeDefinition "Weather"
                    (Type.EnumType
                        [ { name = "CLOUDY", description = Nothing }
                        , { name = "SUNNY", description = Nothing }
                        ]
                    )
                    Nothing
                ]
                    |> TypeLockDefinitions.generate [ "Api" ]
                    |> Expect.equal
                        """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
        , test "generates imports for objects and interfaces" <|
            \() ->
                [ Type.TypeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.TypeDefinition "MyInterface"
                    (Type.InterfaceType [] [])
                    Nothing
                ]
                    |> TypeLockDefinitions.generate [ "Api" ]
                    |> Expect.equal """module Api.Object exposing (..)


type MyObject
    = MyObject


type MyInterface
    = MyInterface
"""
        ]
