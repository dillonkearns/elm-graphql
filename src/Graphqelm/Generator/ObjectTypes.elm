module Graphqelm.Generator.ObjectTypes exposing (generate)

import Graphqelm.Parser.Type exposing (TypeDefinition)


generate : List TypeDefinition -> String
generate typeDefinitions =
    """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
