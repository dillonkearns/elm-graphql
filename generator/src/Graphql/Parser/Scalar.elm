module Graphql.Parser.Scalar exposing (Scalar(..), parse, toAnnotation)

import Elm.Annotation
import Graphql.Generator.Context exposing (Context)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import ModuleName


type Scalar
    = Boolean
    | String
    | Int
    | Float
    | Custom ClassCaseName


parse : String -> Scalar
parse scalarName =
    case scalarName of
        "String" ->
            String

        "Boolean" ->
            Boolean

        "Int" ->
            Int

        "Float" ->
            Float

        _ ->
            Custom (ClassCaseName.build scalarName)


toString : Scalar -> String
toString scalar =
    case scalar of
        String ->
            "String"

        Boolean ->
            "Boolean"

        Int ->
            "Int"

        Float ->
            "Float"

        Custom customScalarName ->
            customScalarName
                |> ClassCaseName.raw


toAnnotation : Context -> Scalar -> Elm.Annotation.Annotation
toAnnotation context scalar =
    case scalar of
        String ->
            Elm.Annotation.string

        Boolean ->
            Elm.Annotation.bool

        Int ->
            Elm.Annotation.int

        Float ->
            Elm.Annotation.float

        Custom customScalarName ->
            (context.scalarCodecsModule
                |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ]))
            )
                |> ModuleName.toAnnotation (ClassCaseName.normalized customScalarName)
