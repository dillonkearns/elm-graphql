module Graphql.Generator.ReferenceLeaf exposing (ReferenceLeaf(..), get)

import Graphql.Parser.Type as Type exposing (TypeReference(..))


type ReferenceLeaf
    = Object
    | Enum
    | Union
    | Interface
    | Scalar



-- type TypeReference
--     = TypeReference ReferrableType IsNullable


get : TypeReference -> Result String ReferenceLeaf
get (TypeReference referrableType isNullable) =
    case referrableType of
        Type.ObjectRef _ ->
            Ok Object

        Type.Scalar _ ->
            Ok Scalar

        Type.List nestedType ->
            get nestedType

        Type.EnumRef _ ->
            Ok Enum

        Type.InputObjectRef _ ->
            Err "TODO"

        Type.UnionRef _ ->
            Ok Union

        Type.InterfaceRef _ ->
            Ok Interface
