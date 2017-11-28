module GraphqElm.Generator.Module exposing (..)

import GraphqElm.Generator.Group
import GraphqElm.Generator.Query as Query
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)


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


generateNew : GraphqElm.Generator.Group.Group -> String
generateNew group =
    prepend
        ++ (List.map Query.generateNew group.queries |> String.join "\n\n")


generate : List { name : String, typeOf : TypeDefinition } -> String
generate fields =
    prepend
        ++ (List.map Query.generate fields |> String.join "\n\n")
