module Generator.TypeLockDefinitionsTests exposing (all)

import Expect
import Graphqelm.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type as Type exposing (..)
import Test exposing (..)


all : Test
all =
    describe "object types generator"
        [ test "enum has no object definitions" <|
            \() ->
                [ Type.typeDefinition "Weather"
                    (Type.EnumType
                        [ { name = ClassCaseName.build "CLOUDY", description = Nothing }
                        , { name = ClassCaseName.build "SUNNY", description = Nothing }
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
                [ Type.typeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.typeDefinition "MyInterface"
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
                [ Type.typeDefinition "_MyObject"
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
                [ Type.typeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.typeDefinition "MyInterface"
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
