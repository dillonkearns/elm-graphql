module Graphql.Generator.Context exposing (Context, stub)

import Dict exposing (Dict)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type exposing (TypeDefinition)
import ModuleName exposing (ModuleName)


context :
    { query : String
    , mutation : Maybe String
    , subscription : Maybe String
    , apiSubmodule : List String
    , interfaces : InterfaceLookup
    , scalarCodecsModule : Maybe ModuleName
    }
    -> Context
context { query, mutation, apiSubmodule, interfaces, subscription, scalarCodecsModule } =
    { query = ClassCaseName.build query
    , mutation = mutation |> Maybe.map ClassCaseName.build
    , subscription = subscription |> Maybe.map ClassCaseName.build
    , apiSubmodule = apiSubmodule
    , interfaces = interfaces
    , scalarCodecsModule = scalarCodecsModule
    }


type alias Context =
    { query : ClassCaseName
    , mutation : Maybe ClassCaseName
    , subscription : Maybe ClassCaseName
    , apiSubmodule : List String
    , interfaces : InterfaceLookup
    , scalarCodecsModule : Maybe ModuleName
    }


stub : Context
stub =
    { query = ClassCaseName.build "RootQueryObject"
    , mutation = Nothing
    , subscription = Nothing
    , apiSubmodule = [ "Api" ]
    , interfaces = Dict.empty
    , scalarCodecsModule = Nothing
    }


type alias InterfaceLookup =
    Dict String (List TypeDefinition)
