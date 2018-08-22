module Graphql.Generator.Context exposing (Context, context)

import Dict exposing (Dict)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)


context :
    { query : String
    , mutation : Maybe String
    , subscription : Maybe String
    , apiSubmodule : List String
    , interfaces : InterfaceLookup
    }
    -> Context
context { query, mutation, apiSubmodule, interfaces, subscription } =
    { query = ClassCaseName.build query
    , mutation = mutation |> Maybe.map ClassCaseName.build
    , subscription = subscription |> Maybe.map ClassCaseName.build
    , apiSubmodule = apiSubmodule
    , interfaces = interfaces
    }


type alias Context =
    { query : ClassCaseName
    , mutation : Maybe ClassCaseName
    , subscription : Maybe ClassCaseName
    , apiSubmodule : List String
    , interfaces : InterfaceLookup
    }


type alias InterfaceLookup =
    Dict String (List ClassCaseName)
