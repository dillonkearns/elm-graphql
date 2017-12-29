module Graphqelm.Generator.DocComment exposing (generate)

import Graphqelm.Parser.Type as Type exposing (Field, ReferrableType, TypeReference)
import Interpolate exposing (interpolate)


generate : Field -> String
generate { description } =
    case description of
        Just actualDescription ->
            interpolate """{-| {0}
-}
"""
                [ actualDescription ]

        Nothing ->
            ""
