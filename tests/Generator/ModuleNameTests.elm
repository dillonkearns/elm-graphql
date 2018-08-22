module Generator.ModuleNameTests exposing (all)

import Dict
import Expect
import Graphql.Generator.Context as Context
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Test exposing (..)


all : Test
all =
    describe "module name"
        [ test "use RootQuery module name" <|
            \() ->
                ModuleName.object
                    (Context.context
                        { query = "RootQueryType"
                        , mutation = Nothing
                        , subscription = Nothing
                        , apiSubmodule = [ "Api" ]
                        , interfaces = Dict.empty
                        }
                    )
                    (ClassCaseName.build "RootQueryType")
                    |> Expect.equal [ "RootQuery" ]
        ]
