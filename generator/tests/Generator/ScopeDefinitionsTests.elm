module Generator.ScopeDefinitionsTests exposing (all)

import Expect
import Graphql.Generator.ScopeDefinitions as ScopeDefinitions
import Graphql.Parser.Type as Type exposing (..)
import Test exposing (..)


all : Test
all =
    describe "object types generator"
        [ test "generates placeholders for types with no definitions" <|
            \() ->
                []
                    |> ScopeDefinitions.generate [ "Api" ]
                    |> Expect.equal
                        [ ( [ "Api", "Union" ], "module Api.Union exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Object" ], "module Api.Object exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Interface" ], "module Api.Interface exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ) ]
        , test "generates imports for interfaces" <|
            \() ->
                [ typeDefinition "MyObject"
                    (ObjectType [] [])
                    Nothing
                , typeDefinition "MyInterface"
                    (InterfaceType [] [] [])
                    Nothing
                ]
                    |> ScopeDefinitions.generate [ "Api" ]
                    |> Expect.equal
                        [ ( [ "Api", "Union" ], "module Api.Union exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    \"\"\n" ), ( [ "Api", "Object" ], "module Api.Object exposing (..)\n\n\ntype MyObject\n    = MyObject\n" ), ( [ "Api", "Interface" ], "module Api.Interface exposing (..)\n\n\ntype MyInterface\n    = MyInterface\n" ) ]
        ]
