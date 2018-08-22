module Generator.TypeLockDefinitionsTests exposing (all)

import Expect
import Graphql.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphql.Parser.Type as Type exposing (..)
import Test exposing (..)


all : Test
all =
    describe "object types generator"
        [ test "generates placeholders for types with no definitions" <|
            \() ->
                []
                    |> TypeLockDefinitions.generate [ "Api" ]
                    |> Expect.equal
                        [ ( [ "Api", "Union" ], "module Api.Union exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Object" ], "module Api.Object exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Interface" ], "module Api.Interface exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ) ]
        , test "generates imports for interfaces" <|
            \() ->
                [ Type.typeDefinition "MyObject"
                    (Type.ObjectType [])
                    Nothing
                , Type.typeDefinition "MyInterface"
                    (Type.InterfaceType [] [])
                    Nothing
                ]
                    |> TypeLockDefinitions.generate [ "Api" ]
                    |> Expect.equal
                        [ ( [ "Api", "Union" ], "module Api.Union exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Object" ], "module Api.Object exposing (..)\n\n\ntype MyObject\n    = MyObject\n" ), ( [ "Api", "Interface" ], "module Api.Interface exposing (..)\n\n\ntype MyInterface\n    = MyInterface\n" ) ]
        ]
