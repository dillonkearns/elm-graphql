module Graphql.Generator.InputObjectFile.Details exposing (InputObjectDetails)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))


type alias InputObjectDetails =
    { definableType : Type.DefinableType
    , fields : List Type.Field
    , name : ClassCaseName
    , hasLoop : Bool
    }
