module Graphqelm.Generator.ObjectTypes exposing (generate)


generate : a -> String
generate a =
    """module Api.Object exposing (..)


type Character
    = Character
"""
