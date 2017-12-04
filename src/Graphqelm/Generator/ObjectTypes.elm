module Graphqelm.Generator.ObjectTypes exposing (generate)

import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))


generate : List TypeDefinition -> String
generate typeDefinitions =
    if List.filterMap nameIfDefinitionNeeded typeDefinitions == [] then
        """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
    else
        """module Api.Object exposing (..)


type MyObject
    = MyObject
"""


nameIfDefinitionNeeded : TypeDefinition -> Maybe String
nameIfDefinitionNeeded (TypeDefinition name definableType) =
    case definableType of
        Type.ObjectType _ ->
            Just name

        _ ->
            Nothing
