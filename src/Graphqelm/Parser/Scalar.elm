module Graphqelm.Parser.Scalar exposing (..)


type Scalar
    = Boolean
      -- | ID
    | String
    | Int
    | Float


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

        "ID" ->
            -- TODO is it worth the overhead for the user of having a special union type here?
            String

        _ ->
            String
