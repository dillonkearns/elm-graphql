module Generator.ModuleNameTests exposing (all)

import Dict
import Expect
import Graphql.Generator.Context as Context exposing (stub)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Test exposing (..)


all : Test
all =
    describe "module name"
        [ test "use RootQuery module name" <|
            \() ->
                ModuleName.object
                    { stub
                        | query = "RootQueryType" |> ClassCaseName.build
                    }
                    (ClassCaseName.build "RootQueryType")
                    |> Expect.equal [ "RootQuery" ]
        ]
