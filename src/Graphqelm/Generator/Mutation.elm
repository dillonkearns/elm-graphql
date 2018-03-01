module Graphqelm.Generator.Mutation exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.StaticImports as StaticImports
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : Context -> List String -> List Field -> String
generate context moduleName fields =
    prepend context moduleName fields
        ++ (List.map (FieldGenerator.generateForObject context (context.mutation |> Maybe.withDefault (ClassCaseName.build ""))) fields |> String.join "\n\n")


prepend : Context -> List String -> List Field -> String
prepend ({ apiSubmodule } as context) moduleName fields =
    interpolate
        """module {0} exposing (..)

{2}
{1}


{-| Select fields to build up a top-level mutation. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    Object.selection constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , StaticImports.all context
        ]
