module GraphqElm.Generator.Module exposing (..)

import GraphqElm.Generator.Query as Query
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)


prepend : String
prepend =
    """module Api.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)


"""


generateNew : List Field -> String
generateNew fields =
    prepend
        ++ (List.map Query.generateNew fields |> String.join "\n\n")
