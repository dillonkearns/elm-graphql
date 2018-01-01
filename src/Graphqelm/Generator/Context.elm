module Graphqelm.Generator.Context exposing (Context)


type alias Context =
    { query : String
    , mutation : Maybe String
    , apiSubmodule : List String
    }
