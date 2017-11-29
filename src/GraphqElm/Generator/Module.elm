module GraphqElm.Generator.Module exposing (..)

-- import GraphqElm.Field as Field exposing (Field, FieldDecoder)

import GraphqElm.Generator.Query as Query
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)
import String.Format


prepend : String -> String
prepend moduleName =
    String.Format.format1
        """module Api.{1} exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)

type Type
    = Type
"""
        moduleName


generateNew : List String -> List Field -> String
generateNew moduleName fields =
    prepend (String.join "." moduleName)
        ++ (List.map Query.generateNew fields |> String.join "\n\n")
