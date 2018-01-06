module Generator.TypeLockDefinitionsTests exposing (all)

import Expect
import Graphqelm.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphqelm.Parser.EnumName exposing (enumName)
import Graphqelm.Parser.Type as Type exposing (..)
import Test exposing (..)


all : Test
all =
    describe "object types generator"
        [ test "enum has no object definitions" <|
            \() ->
                [ Type.TypeDefinition "Weather"
                    (Type.EnumType
                        [ { name = enumName "CLOUDY", description = Nothing }
                        , { name = enumName "SUNNY", description = Nothing }
                        ]
                    )
                    Nothing
                ]
                    |> TypeLockDefinitions.generateObjects [ "Api" ]
                    |> Expect.equal
                        ( [ "Api", "Object" ]
                        , """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
                        )
        , test "generates imports for objects" <|
            \() ->
                [ Type.TypeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.TypeDefinition "MyInterface"
                    (Type.InterfaceType [] [])
                    Nothing
                ]
                    |> TypeLockDefinitions.generateObjects [ "Api" ]
                    |> Expect.equal
                        ( [ "Api", "Object" ]
                        , """module Api.Object exposing (..)


type MyObject
    = MyObject
"""
                        )
        , test "normalizes object names" <|
            \() ->
                [ Type.TypeDefinition "_MyObject"
                    (Type.ObjectType [])
                    Nothing
                ]
                    |> TypeLockDefinitions.generateObjects [ "Api" ]
                    |> Expect.equal
                        ( [ "Api", "Object" ]
                        , """module Api.Object exposing (..)


type MyObject_
    = MyObject_
"""
                        )
        , test "generates imports for interfaces" <|
            \() ->
                [ Type.TypeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.TypeDefinition "MyInterface"
                    (Type.InterfaceType [] [])
                    Nothing
                ]
                    |> TypeLockDefinitions.generateInterfaces [ "Api" ]
                    |> Expect.equal
                        ( [ "Api", "Interface" ]
                        , """module Api.Interface exposing (..)


type MyInterface
    = MyInterface
"""
                        )
        ]
