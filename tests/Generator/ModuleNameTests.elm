module Generator.ModuleNameTests exposing (all)

import Dict
import Expect
import Graphqelm.Generator.ModuleName as ModuleName
import Test exposing (..)


all : Test
all =
    describe "module name"
        [ test "use RootQuery module name" <|
            \() ->
                ModuleName.object
                    { query = "RootQueryType"
                    , mutation = Nothing
                    , apiSubmodule = [ "Api" ]
                    , interfaces = Dict.empty
                    }
                    "RootQueryType"
                    |> Expect.equal [ "RootQuery" ]
        ]
