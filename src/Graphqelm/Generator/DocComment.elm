module Graphqelm.Generator.DocComment exposing (generate)

import Interpolate exposing (interpolate)


generate : Maybe String -> String
generate maybeDescription =
    case maybeDescription of
        Just description ->
            interpolate """{-| {0}
-}
"""
                [ description ]

        Nothing ->
            ""
