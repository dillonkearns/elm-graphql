module Graphql.Generator.Query exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Field as FieldGenerator
import Graphql.Generator.Imports as Imports
import Graphql.Generator.StaticImports as StaticImports
import Graphql.Parser.Type as Type exposing (Field)
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : Context -> List String -> List Field -> Result String String
generate context moduleName fields =
    fields
        |> List.map
            (FieldGenerator.generateForObject context context.query)
        |> Result.Extra.combine
        |> Result.map
            (\fields_ ->
                prepend context moduleName fields
                    ++ (fields_ |> String.join "\n\n")
            )


prepend : Context -> List String -> List Field -> String
prepend ({ apiSubmodule } as context) moduleName fields =
    interpolate
        """module {0} exposing (..)

{2}
{1}
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , StaticImports.all context
        ]
