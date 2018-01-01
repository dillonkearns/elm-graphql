module Graphqelm.Generator.Context exposing (Context)

import Dict exposing (Dict)


type alias Context =
    { query : String
    , mutation : Maybe String
    , apiSubmodule : List String
    , interfaces : InterfaceLookup
    }


type alias InterfaceLookup =
    Dict String (List String)
