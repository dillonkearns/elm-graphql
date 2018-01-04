module Graphqelm.Generator.ModuleName exposing (enum, interface, object)

import Graphqelm.Generator.Context exposing (Context)


object : Context -> String -> List String
object { query, mutation, apiSubmodule } name =
    if name == query then
        [ "RootQuery" ]
    else if Just name == mutation then
        [ "RootMutation" ]
    else
        apiSubmodule ++ [ "Object", name ]


interface : Context -> String -> List String
interface { apiSubmodule } name =
    apiSubmodule ++ [ "Interface", name ]


enum : { context | apiSubmodule : List String } -> String -> List String
enum { apiSubmodule } name =
    apiSubmodule ++ [ "Enum", name ]
