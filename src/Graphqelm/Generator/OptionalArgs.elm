module Graphqelm.Generator.OptionalArgs exposing (Result, generate)

import Graphqelm.Parser.Type as Type


type alias Result =
    String


generate : List Type.Arg -> Maybe Result
generate args =
    Nothing
