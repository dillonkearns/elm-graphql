module Graphql.Parser.Scalar exposing (Scalar(..), parse)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)


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
