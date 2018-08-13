module Graphqelm.Generator.InputObjectFile.Details exposing (InputObjectDetails)

import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition(..))


type alias InputObjectDetails =
    { definableType : Type.DefinableType
    , fields : List Type.Field
    , name : ClassCaseName
    , hasLoop : Bool
    }
