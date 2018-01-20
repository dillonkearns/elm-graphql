module Generator.ModuleNameTests exposing (all)

import Dict
import Expect
import Graphqelm.Generator.Context as Context
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
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
